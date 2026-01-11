# FastAPI + TimescaleDB Energy Data API

## Complete Implementation Template

This template provides a complete, working FastAPI application with TimescaleDB for energy data management, adapted from the Neon TimescaleDB guide for NordicFlux energy optimization.

## Project Structure

```
01_fastapi_timescaledb/
├── src/
│   ├── database/
│   │   └── postgres.py
│   ├── models/
│   │   └── energy_models.py
│   ├── routes/
│   │   └── energy_routes.py
│   └── main.py
├── docker-compose.yml
├── Dockerfile
├── requirements.txt
├── .env.example
└── README.md
```

## Database Schema (Energy-Specific)

```sql
-- Enable TimescaleDB extension
CREATE EXTENSION IF NOT EXISTS timescaledb;

-- Energy devices table
CREATE TABLE IF NOT EXISTS energy_devices (
    device_id SERIAL PRIMARY KEY,
    device_type VARCHAR(50) NOT NULL, -- 'battery', 'heat_pump', 'solar'
    brand VARCHAR(50) NOT NULL,       -- 'tesla', 'nibe', 'victron'
    model VARCHAR(100),
    location VARCHAR(255),
    capacity_kwh FLOAT,               -- Battery capacity or heat pump power
    tenant_id UUID NOT NULL,          -- Multi-tenant support
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Energy telemetry data (time-series)
CREATE TABLE IF NOT EXISTS energy_telemetry (
    device_id INT REFERENCES energy_devices(device_id),
    timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    power_kw FLOAT,                   -- Current power (positive = charging/heating)
    energy_kwh FLOAT,                 -- Cumulative energy
    temperature_c FLOAT,              -- Battery/ambient temperature
    soc_percent FLOAT,                -- State of charge (batteries)
    cop FLOAT,                        -- Coefficient of performance (heat pumps)
    tenant_id UUID NOT NULL,
    PRIMARY KEY(device_id, timestamp)
);

-- Convert to hypertable for time-series optimization
SELECT create_hypertable('energy_telemetry', 'timestamp');

-- Add tenant isolation index
CREATE INDEX ON energy_telemetry (tenant_id, timestamp DESC);

-- Energy pricing data
CREATE TABLE IF NOT EXISTS energy_prices (
    timestamp TIMESTAMPTZ NOT NULL,
    price_zone VARCHAR(10) NOT NULL,  -- 'SE3', 'SE4', etc.
    price_eur_mwh FLOAT NOT NULL,
    PRIMARY KEY(timestamp, price_zone)
);

SELECT create_hypertable('energy_prices', 'timestamp');
```

## Pydantic Models (energy_models.py)

```python
from pydantic import BaseModel, Field
from typing import List, Optional
from datetime import datetime, date
from enum import Enum
import uuid

class DeviceType(str, Enum):
    BATTERY = "battery"
    HEAT_PUMP = "heat_pump"
    SOLAR = "solar"

class DeviceBrand(str, Enum):
    TESLA = "tesla"
    NIBE = "nibe"
    VICTRON = "victron"
    HUAWEI = "huawei"

class EnergyDeviceCreate(BaseModel):
    device_type: DeviceType
    brand: DeviceBrand
    model: Optional[str] = None
    location: str
    capacity_kwh: float = Field(gt=0, description="Device capacity in kWh")
    tenant_id: uuid.UUID

class EnergyTelemetry(BaseModel):
    power_kw: float = Field(description="Current power in kW (+ = charging/heating)")
    energy_kwh: Optional[float] = Field(None, description="Cumulative energy in kWh")
    temperature_c: Optional[float] = Field(None, description="Temperature in Celsius")
    soc_percent: Optional[float] = Field(None, ge=0, le=100, description="State of charge %")
    cop: Optional[float] = Field(None, gt=0, description="Coefficient of performance")
    timestamp: datetime = Field(default_factory=datetime.utcnow)

class EnergyTelemetryBatch(BaseModel):
    data: List[EnergyTelemetry]

class EnergyDailyStats(BaseModel):
    day: date
    device_id: int
    avg_power_kw: float
    min_power_kw: float
    max_power_kw: float
    total_energy_kwh: float
    avg_soc_percent: Optional[float] = None
    avg_temperature_c: Optional[float] = None
    reading_count: int

class EnergyPrice(BaseModel):
    timestamp: datetime
    price_zone: str
    price_eur_mwh: float
```

## FastAPI Routes (energy_routes.py)

```python
from fastapi import HTTPException, Path, Body, APIRouter, Depends, Query
from database.postgres import get_postgres
from typing import Union, List, Optional
from asyncpg import Pool
from loguru import logger
from models.energy_models import (
    EnergyDeviceCreate,
    EnergyTelemetry,
    EnergyTelemetryBatch,
    EnergyDailyStats,
    EnergyPrice
)
import uuid

energy_router = APIRouter()

@energy_router.post("/devices")
async def create_energy_device(
    device: EnergyDeviceCreate = Body(...), 
    db: Pool = Depends(get_postgres)
):
    """Create a new energy device (battery, heat pump, solar)."""
    insert_query = """
    INSERT INTO energy_devices (device_type, brand, model, location, capacity_kwh, tenant_id)
    VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING device_id;
    """
    
    logger.info(f"Creating {device.device_type} device: {device.brand} {device.model}")
    
    async with db.acquire() as conn:
        device_id = await conn.fetchval(
            insert_query, 
            device.device_type, device.brand, device.model, 
            device.location, device.capacity_kwh, device.tenant_id
        )
    
    if device_id is None:
        raise HTTPException(status_code=500, detail="Failed to create device")
    
    logger.info(f"Energy device created with ID: {device_id}")
    return {"device_id": device_id, "message": "Energy device created successfully"}

@energy_router.post("/telemetry/{device_id}")
async def stream_energy_telemetry(
    device_id: int = Path(...),
    telemetry: Union[EnergyTelemetry, EnergyTelemetryBatch] = Body(...),
    tenant_id: uuid.UUID = Query(...),
    db: Pool = Depends(get_postgres)
):
    """Stream energy telemetry data (single point or batch)."""
    insert_query = """
    INSERT INTO energy_telemetry 
    (device_id, timestamp, power_kw, energy_kwh, temperature_c, soc_percent, cop, tenant_id)
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8);
    """
    
    logger.info(f"Streaming telemetry for device {device_id}")
    
    async with db.acquire() as conn:
        async with conn.transaction():
            if isinstance(telemetry, EnergyTelemetryBatch):
                for data in telemetry.data:
                    await conn.execute(
                        insert_query,
                        device_id, data.timestamp, data.power_kw, data.energy_kwh,
                        data.temperature_c, data.soc_percent, data.cop, tenant_id
                    )
            else:
                await conn.execute(
                    insert_query,
                    device_id, telemetry.timestamp, telemetry.power_kw, telemetry.energy_kwh,
                    telemetry.temperature_c, telemetry.soc_percent, telemetry.cop, tenant_id
                )
    
    return {"message": "Energy telemetry streamed successfully"}

@energy_router.get("/stats/{device_id}", response_model=List[EnergyDailyStats])
async def get_energy_daily_stats(
    device_id: int = Path(...),
    tenant_id: uuid.UUID = Query(...),
    days: int = Query(7, ge=1, le=30),
    db: Pool = Depends(get_postgres)
):
    """Get daily energy statistics for a device."""
    query = """
    WITH daily_stats AS (
        SELECT
            time_bucket('1 day', timestamp) AS day,
            device_id,
            avg(power_kw) AS avg_power_kw,
            min(power_kw) AS min_power_kw,
            max(power_kw) AS max_power_kw,
            sum(CASE WHEN power_kw > 0 THEN power_kw * 0.25 ELSE 0 END) AS total_energy_kwh,
            avg(soc_percent) AS avg_soc_percent,
            avg(temperature_c) AS avg_temperature_c,
            count(*) AS reading_count
        FROM energy_telemetry
        WHERE device_id = $1 AND tenant_id = $2
        AND timestamp >= NOW() - INTERVAL '%s days'
        GROUP BY day, device_id
    )
    SELECT * FROM daily_stats
    ORDER BY day DESC
    LIMIT $3;
    """ % days
    
    async with db.acquire() as conn:
        rows = await conn.fetch(query, device_id, tenant_id, days)
    
    if not rows:
        raise HTTPException(status_code=404, detail="No data found for this device")
    
    return [
        EnergyDailyStats(
            day=row["day"].date(),
            device_id=row["device_id"],
            avg_power_kw=row["avg_power_kw"],
            min_power_kw=row["min_power_kw"],
            max_power_kw=row["max_power_kw"],
            total_energy_kwh=row["total_energy_kwh"],
            avg_soc_percent=row["avg_soc_percent"],
            avg_temperature_c=row["avg_temperature_c"],
            reading_count=row["reading_count"]
        )
        for row in rows
    ]

@energy_router.post("/prices/batch")
async def upload_energy_prices(
    prices: List[EnergyPrice] = Body(...),
    db: Pool = Depends(get_postgres)
):
    """Upload batch energy price data."""
    insert_query = """
    INSERT INTO energy_prices (timestamp, price_zone, price_eur_mwh)
    VALUES ($1, $2, $3)
    ON CONFLICT (timestamp, price_zone) DO UPDATE SET
    price_eur_mwh = EXCLUDED.price_eur_mwh;
    """
    
    async with db.acquire() as conn:
        async with conn.transaction():
            for price in prices:
                await conn.execute(
                    insert_query,
                    price.timestamp, price.price_zone, price.price_eur_mwh
                )
    
    return {"message": f"Uploaded {len(prices)} price records"}
```

## Docker Compose Configuration

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "8000:8000"
    command: uvicorn main:app --host 0.0.0.0 --port 8000 --reload
    volumes:
      - ./src:/app/src
    environment:
      - DATABASE_URL=postgresql://nordicflux:password@timescaledb:5432/nordicflux
    depends_on:
      - timescaledb

  timescaledb:
    image: timescale/timescaledb:latest-pg15
    environment:
      - POSTGRES_DB=nordicflux
      - POSTGRES_USER=nordicflux
      - POSTGRES_PASSWORD=password
    ports:
      - "5432:5432"
    volumes:
      - timescale_data:/var/lib/postgresql/data
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql

volumes:
  timescale_data:
```

## Requirements.txt

```
fastapi==0.104.1
uvicorn[standard]==0.24.0
asyncpg==0.29.0
pydantic==2.5.0
python-dotenv==1.0.0
loguru==0.7.2
```

## Environment Configuration (.env.example)

```
DATABASE_URL=postgresql://nordicflux:password@localhost:5432/nordicflux
LOG_LEVEL=INFO
```

## Usage Instructions

1. **Copy template**: `cp -r 01_fastapi_timescaledb/ your_project/`
2. **Set environment**: `cp .env.example .env`
3. **Start services**: `docker-compose up -d --build`
4. **Test API**: Visit `http://localhost:8000/docs`

## Testing Examples

```bash
# Create a Tesla Powerwall
curl -X POST "http://localhost:8000/devices" \
  -H "Content-Type: application/json" \
  -d '{
    "device_type": "battery",
    "brand": "tesla",
    "model": "Powerwall 2",
    "location": "Garage",
    "capacity_kwh": 13.5,
    "tenant_id": "123e4567-e89b-12d3-a456-426614174000"
  }'

# Stream telemetry data
curl -X POST "http://localhost:8000/telemetry/1?tenant_id=123e4567-e89b-12d3-a456-426614174000" \
  -H "Content-Type: application/json" \
  -d '{
    "power_kw": 5.2,
    "soc_percent": 85.5,
    "temperature_c": 22.1
  }'

# Get daily statistics
curl "http://localhost:8000/stats/1?tenant_id=123e4567-e89b-12d3-a456-426614174000&days=7"
```

This template provides a complete, production-ready foundation for energy data management with TimescaleDB optimization.

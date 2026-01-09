# Project Structure

## Directory Layout
```
NordicFlux/
├── backend/
│   ├── app/
│   │   ├── engine/
│   │   │   ├── mpc.py              # EnergyOptimizer class (CVXPY)
│   │   │   ├── thermal_learning.py # RC parameter regression
│   │   │   └── degradation.py      # Battery degradation modeling
│   │   ├── adapters/
│   │   │   ├── __init__.py
│   │   │   ├── base.py             # Abstract EnergyDevice
│   │   │   ├── tesla.py            # TeslaAdapter (cloud API)
│   │   │   ├── victron.py          # VictronAdapter (cloud API)
│   │   │   ├── nibe.py             # NibeAdapter (myUplink API)
│   │   │   └── mqtt.py             # MqttAdapter (Pi gateway)
│   │   ├── services/
│   │   │   ├── price_service.py    # Energi Data Service integration
│   │   │   ├── weather_service.py  # Met.no integration
│   │   │   └── device_discovery.py # Auto-detection service
│   │   ├── models/
│   │   │   └── database.py         # SQLAlchemy models
│   │   ├── api/
│   │   │   └── routes.py           # FastAPI endpoints
│   │   └── main.py                 # FastAPI app
│   ├── requirements.txt
│   └── Dockerfile
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   │   ├── Simulator.tsx       # Savings simulation
│   │   │   ├── Dashboard.tsx       # Live status
│   │   │   └── Onboarding.tsx      # Device auto-detection
│   │   └── App.tsx
│   ├── package.json
│   └── Dockerfile
├── gateway/
│   ├── adapters/
│   │   ├── nibe_gateway.py         # NIBE F-series Modbus
│   │   └── huawei_gateway.py       # Huawei inverter gateway
│   ├── mqtt_bridge.py              # Generic MQTT bridge
│   └── requirements.txt
├── docker-compose.yml
└── .kiro/
```

## File Naming Conventions
**Python**: snake_case for files and functions, PascalCase for classes
**TypeScript**: PascalCase for components, camelCase for functions
**Config**: lowercase with hyphens (docker-compose.yml)

## Module Organization
**Backend**: Domain-driven structure (engine, adapters, services, models, api)
**Frontend**: Feature-based components with shared utilities
**Gateway**: Single-purpose lightweight scripts

## Configuration Files
**Backend**: .env for secrets, settings.py for app config
**Frontend**: .env.local for API endpoints
**Docker**: docker-compose.yml for orchestration
**Database**: alembic/ for migrations

## Documentation Structure
**API**: OpenAPI/Swagger auto-generated docs
**Code**: Docstrings for MPC physics and optimization logic
**Setup**: README.md with Docker Compose instructions
**Architecture**: docs/ folder for system design

## Asset Organization
**Frontend**: public/ for static assets, src/assets/ for bundled resources
**Images**: Optimized formats, lazy loading for charts

## Build Artifacts
**Backend**: __pycache__/, .pytest_cache/
**Frontend**: dist/, node_modules/
**Docker**: Built images, volumes for persistent data

## Environment-Specific Files
**Development**: docker-compose.override.yml
**Production**: docker-compose.prod.yml
**Testing**: pytest.ini, .env.test

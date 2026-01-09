# Technical Architecture

## Technology Stack
**Core Stack**: Python 3.11+ Monorepo with FastAPI backend and React frontend
- **Backend**: FastAPI (async), SQLAlchemy 2.0, PostgreSQL
- **Math Engine**: CVXPY for Model Predictive Control optimization
- **Task Queue**: Redis + Celery for background MPC computations
- **Frontend**: React (Vite), TypeScript, Tailwind CSS, Recharts
- **Gateway**: Lightweight Python (Paho-MQTT) for Raspberry Pi
- **Deployment**: Docker Compose on Linux VPS

## Architecture Overview
**Zero-Cost Data Sources**:
- **Price Data**: Energi Data Service (Denmark) API for SE3/SE4 spot prices (no registration required)
- **Price Fallback**: ENTSO-E Transparency Platform (if/when API becomes stable)
- **Weather Data**: Met.no API via metno-locationforecast library
- **Caching**: Redis for 24h price/weather data to respect rate limits

**Core Components**:
- **EnergyOptimizer**: CVXPY-based MPC solver with HiGHS or CBC backend and RC thermal model (VPS-hosted)
- **Battery Degradation Model**: Cycle cost integration to prevent excessive charge/discharge cycles
- **Thermal Learning**: Linear regression to auto-calibrate R/C parameters from observed data
- **Device Adapters**: Factory pattern for cloud and gateway integrations
- **Data Services**: Price fetcher (SE3/SE4 zones), weather service (lat/lon)
- **Background Jobs**: Celery workers for optimization scheduling
- **MQTT Infrastructure**: Paho-MQTT client + broker (Mosquitto) for gateway communication

**Deployment Strategy**:
- **VPS Hosting**: Hetzner (cost-effective European hosting)
- **Centralized Optimization**: All MPC computations on VPS (x86 reliability)
- **Edge Gateways**: Raspberry Pi as "dumb bridge" for local device communication

## Device Integration Architecture

**Cloud Integrations** (Direct API access):
- **Tesla**: Powerwall API via Tesla Fleet API
- **Victron**: VRM Portal API for GX devices
- **Huawei**: FusionSolar API for inverter systems
- **NIBE S-Series**: myUplink API for smart heat pumps

**Gateway Integrations** (Raspberry Pi bridge required):
- **NIBE F-Series**: Modbus 40 accessory or USB-to-RS485 + Husdata H1
- **Huawei Local**: Direct inverter communication via Pi gateway
- **Generic Modbus**: Any Modbus RTU/TCP device via Pi gateway
- **Custom Protocols**: Extensible for proprietary local interfaces

**MQTT Infrastructure**:
- **Broker**: Mosquitto running on VPS for centralized message routing
- **Client**: Paho-MQTT library for Python gateway and backend communication
- **Topics**: Structured hierarchy for device commands and telemetry

## Development Environment
**Required Tools**:
- Python 3.11+, Node.js 18+, Docker & Docker Compose
- PostgreSQL, Redis (via Docker)
- Package managers: pip, npm/yarn

**Key Dependencies**:
```
fastapi, uvicorn, sqlalchemy, pydantic-settings
cvxpy, requests, metno-locationforecast
celery, redis, psycopg2-binary
scikit-learn  # For thermal parameter regression
paho-mqtt     # For MQTT client communication
```

## Code Standards
**Python**: Black formatting, type hints, Pydantic V2 validation
**TypeScript**: ESLint + Prettier, strict mode
**API**: RESTful design, async/await patterns
**Documentation**: Docstrings for all MPC logic and physics models

## Thermal Parameter Learning
**Approach**: Linear regression using scikit-learn for RC thermal model calibration
**Physics Model**: `T_next = T_current + (1/C) * ((T_outdoor - T_current)/R + HeaterPower) * dt`
**Learning Process**:
- Collect: Temperature readings, heater power, outdoor temperature, time deltas
- Fit: Linear regression on temperature changes vs input features
- Extract: Convert regression coefficients to thermal resistance (R) and capacitance (C)
- Validate: Ensure R/C values are physically reasonable for building type
- Update: Re-run regression periodically with accumulated data

**COP Non-linearity Handling**:
Heat pump efficiency (COP) varies significantly with outdoor temperature, affecting actual heat delivered. Implementation strategy:
- **Phase 1**: Start with basic linear regression, monitor prediction accuracy
- **Phase 2**: Add temperature segmentation (warm/moderate/cold weather models) if needed
- **Phase 3**: Consider polynomial features only if segmentation insufficient
- **Relevance**: Critical for Swedish heat pumps (COP can vary 2x-3x between summer/winter)

**Rationale**: RC thermal model is fundamentally linear, making linear regression theoretically optimal. Avoids complexity of neural networks while providing interpretable, physics-based parameters for reliable MPC optimization.

## Battery Degradation Modeling
**Problem**: Excessive charge/discharge cycles destroy battery lifespan for minimal savings
**Solution**: Integrate cycle cost into CVXPY objective function
**Math**: `minimize(electricity_cost + battery_throughput * degradation_cost_per_kWh)`
**Implementation**:
- Calculate degradation cost from battery specs (cycle life, replacement cost)
- Add throughput penalty to optimization objective
- Ensure battery usage only when savings exceed wear costs
- Device-specific degradation rates (Tesla, Victron, Huawei have different characteristics)

**Example**: If cycling saves €0.02 but costs €0.05 in degradation, system won't cycle

## Testing Strategy
**Backend**: pytest with async support, MPC solver unit tests
**Frontend**: Vitest for components, integration tests for API calls
**Integration**: Docker Compose test environment
**Coverage**: Focus on MPC optimization logic and constraint handling

## Deployment Process
**Hosting**: Hetzner VPS (cost-effective European hosting)
**Containerization**: Multi-stage Docker builds
**Orchestration**: Docker Compose with PostgreSQL, Redis, API, Frontend
**Environment**: Linux VPS deployment target
**Monitoring**: Health checks for optimization scheduling

## Performance Requirements
**MPC Solver**: <30 seconds for 24-hour optimization
**API Response**: <200ms for simulation endpoints
**Data Refresh**: Hourly price updates, 6-hour weather updates
**Scalability**: Support 1000+ concurrent optimizations

## Security Considerations
**API Access**: No API keys required for Energi Data Service (public data)
**Database**: Connection pooling, parameterized queries
**Device APIs**: OAuth flows for Tesla/Victron (future)
**Local Gateway**: MQTT authentication for Raspberry Pi connections

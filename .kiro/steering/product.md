# Product Overview

## Product Purpose
NordicFlux is a zero-cost SaaS Energy Management System that uses Model Predictive Control (MPC) to optimize Battery Storage (arbitrage) and Thermal Storage (heating) based on free Nordpool spot electricity prices, weather forecasts, and user constraints. The system minimizes energy costs while maintaining comfort by intelligently scheduling battery and heating operations over a 24-hour horizon.

## Target Users
**Primary Audience**: Tech-savvy homeowners with battery storage systems motivated by cost savings and environmental impact.

**Specific Segments**:
- **NIBE F-series Users (Sweden focus)**: 70% of installed base, "dumb" pumps desperate for optimization
- **Home Assistant Enthusiasts**: Already have Pi hardware, perfect early adopters
- **Huawei Solar Users (Gnesta focus)**: Solar + battery optimization market
- **Global Tesla/Victron Users**: Future cloud API expansion

**Device Priority Strategy**:
- **Phase 1**: NIBE S-series (myUplink API) - validate MPC algorithms, cloud-only
- **Phase 2**: Tesla/Victron cloud APIs - global expansion
- **Phase 3**: Huawei systems (Pi gateway) - Gnesta solar + battery market
- **Phase 4**: NIBE F-series (Pi gateway) - capture 70% of Swedish marketI (desperate for a way to optimize consumption without buying a new 100,000 SEK heat pump) 

**Market Reality**:
- **S-series owners**: Already have smart features, harder sell for optimization
- **F-series owners**: "Dumb" pumps, desperate to avoid 100,000 SEK replacement
- **Product-Market Fit**: F-series users with high bills + no smart controls

**User Needs**: Automated energy cost reduction, environmental consciousness, real-time optimization, and integration with existing energy systems.

## Key Features
- **No-Brainer Zero-Cost Offer**: We help you save money and charge 30% of what we help you save (we'll need to do some calculations to ensure this is a feasible choice)
- **Cost-Effective**: Leverage free APIs as much as possible (Energi Data Service, Met.no weather)
- **MPC Optimization**: 24-hour scheduling using CVXPY solver with RC thermal model (Battery Degradation Taken into account - see tech.md)
- **Auto-Calibration**: Continuous learning from real performance data to refine thermal parameters (linear regression and COP Non-linearity Handling if necessary - more details in tech.md)
- **Multi-Device Support**: Extensible adapter pattern for Tesla, Victron, local systems
- **Real-Time Pricing**: Energi Data Service Day-Ahead prices with Redis caching
- **Weather Integration**: Met.no global weather forecasting
- **Savings Simulator**: Historical analysis showing potential cost reductions
- **Background Processing**: Celery + Redis for heavy MPC computations

## Business Objectives
- **Primary**: Reduce user energy costs by 15-30% through intelligent optimization
- **Revenue Model**: 30% of verified savings + hardware partnership revenue share
- **Sustainability**: Zero operational costs using free data sources
- **Scalability**: Docker-based deployment on Linux VPS with intelligent API rate limiting
- **Growth**: Start with Swedish market, expand globally through device partnerships

## User Journey
1. **Auto-Detection**: Scan for compatible devices (Tesla, Victron, Huawei, NIBE) and auto-populate system parameters
2. **Smart Defaults**: Use device-specific thermal and battery parameters (no user input needed)
3. **Immediate Activation**: Start optimization with device-based default parameters
4. **Continuous Learning**: System refines thermal model parameters from real performance data
5. **Simulation**: Run historical analysis to show potential savings with current model
6. **Grid-Safe Operation**: All optimization with no-discharge-to-grid constraint
7. **Monitoring**: Track performance and verified savings via web dashboard
8. **Progressive Enhancement**: Unlock advanced features as user gains confidence

## Success Criteria
- **Cost Savings**: Average 20% reduction in energy bills
- **System Reliability**: 99% uptime for optimization scheduling
- **Zero Operating Costs**: Maintain free API usage within limits
- **User Adoption**: 100+ active users within 6 months
- **Technical Performance**: <5% constraint violations in MPC solutions

## Phased Success Milestones
- **Phase 1 (3 months)**: 10 beta users, 15% average savings validated
- **Phase 2 (6 months)**: 50 active users, 99% system uptime achieved
- **Phase 3 (12 months)**: 200+ users, break-even on hosting costs

## Key Risks & Mitigations
- **API Changes**: Energi Data Service or Met.no modify/restrict access → Implement fallback data sources
- **Device Compatibility**: Manufacturers change protocols → Maintain adapter abstraction layer
- **User Adoption**: Complex setup deters users → Focus on auto-detection and smart defaults
- **Competition**: Tesla/Victron launch similar features → Leverage zero-cost advantage and local focus
- **Regulatory Changes**: Grid connection rules tighten → Start with grid-safe constraints only

## Compliance & Safety Strategy
- **Grid-Safe Operation**: Hard constraint preventing discharge to grid (regulatory compliance)
- **Safety Limits**: Device-specific charge/discharge rate limits from manufacturer specs
- **Liability Model**: Clear separation - system provides recommendations, user retains control
- **Progressive Compliance**: Start grid-safe, add grid services when regulations clarify

## Scaling Strategy
- **API Rate Limiting**: Intelligent batching and request queuing across users
- **Regional Data Sharing**: Cache weather/price data for nearby users (same grid zone)
- **Optimization Scheduling**: Stagger MPC computations to avoid API limits
- **Fallback Systems**: Use cached historical data when APIs temporarily unavailable

## Hardware Integration Strategy
**NIBE F-series Connection Methods**:
- **Method A (Premium)**: NIBE Modbus 40 Accessory (~3000 SEK) - plug-and-play
- **Method B (Hacker-friendly)**: USB-to-RS485 adapter + Husdata H1 interface - cost-effective
- **Target Market**: Home Assistant users who already have Pi hardware

**NordicFlux Agent**: Raspberry Pi Docker container for local device communication
- **Marketing**: "Make your dumb heat pump smart without a subscription"
- **Value Prop**: Avoid 100,000 SEK heat pump replacement + eliminate NIBE Uplink Premium fees

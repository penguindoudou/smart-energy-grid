# Product Overview

## Product Purpose
NordicFlux is a zero-cost SaaS Energy Management System that uses Model Predictive Control (MPC) to optimize Battery Storage (arbitrage) and Heating Optimization (load shifting) based on free Nordpool spot electricity prices, weather forecasts, and user constraints. The system minimizes energy costs while maintaining comfort by intelligently scheduling battery and heating operations over a 24-hour horizon.

## Target Users
**Primary Audience**: Tech-savvy homeowners with battery storage systems motivated by cost savings and environmental impact.

**Specific Segments**:
- **NIBE F-series Users (Sweden focus)**: Significant portion of installed base, basic heat pumps lacking smart controls seeking optimization
- **Home Assistant Enthusiasts**: Already have Pi hardware, perfect early adopters
- **Huawei Solar Users (Gnesta focus)**: Solar + battery optimization market
- **Global Tesla/Victron Users**: Future cloud API expansion

**Device Priority Strategy**:
- **Phase 1**: Cloud API Integration (Tier 1) - Tesla/Victron/NIBE S-series via cloud APIs
- **Phase 2**: Local Pi Gateway (Tier 2) - NIBE F-series, Huawei local, Modbus devices
- **Phase 3**: Hybrid Deployments - Mixed cloud + local device optimization
- **Phase 4**: Advanced Features - Grid services, multi-site optimization

**Market Approach**:
- **Tier 1 (Cloud-Only)**: No hardware required, faster onboarding, 60% of market
- **Tier 2 (Local Pi)**: Hardware required, maximum compatibility + privacy, 40% of market 

**Market Reality**:
- **S-series owners**: Already have smart features (myUplink, WiFi, voice control), harder sell for optimization
- **F-series owners**: Basic pumps lacking smart controls, seeking cost-effective optimization without full replacement
- **Product-Market Fit**: F-series users with high bills + no smart controls + active community seeking solutions

**User Needs**: Automated energy cost reduction, environmental consciousness, real-time optimization, and integration with existing energy systems.

## Key Features
- **No-Brainer Zero-Cost Offer**: We help you save money by optimizing your heating and batteries and charge 30% of what we help you save (we'll need to do some calculations to ensure this is a feasible choice)
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
- **Social Impact**: Democratize energy optimization across income levels through multi-tier pricing
- **Revenue Model**: Tiered pricing strategy from premium cloud to budget local solutions
- **Sustainability**: Zero operational costs using free data sources + local alternatives
- **Scalability**: Docker-based deployment with path to eliminate third-party API dependencies
- **Growth**: Start with one proven integration, expand systematically to multi-tier offerings

## Development Strategy
- **AI-First Development**: Leverage AI coding agents for rapid MVP iteration and reduced development costs
- **Complexity Framework**: Prioritize high-value features that are easy to implement, well-documented, and verifiable
- **Research-Driven**: Continuous market and technical validation through systematic analysis
- **Launch-Ready Focus**: Optimize for MVP deployment speed while maintaining quality standards

## Multi-Tier Business Strategy

### Tier 1: Cloud Integration (Premium Convenience)
- **Target**: Mainstream users wanting plug-and-play experience
- **Price**: % of verified savings (higher due to API costs - TBD after Phase 1 calculations)
- **Setup**: OAuth authentication only, immediate activation
- **Examples**: Tesla Powerwall, NIBE S-series myUplink

### Tier 2: DIY Local Gateway (Budget Technical)
- **Target**: Home Assistant enthusiasts with existing Pi hardware
- **Price**: % of verified savings (lower costs = competitive pricing - TBD after cost analysis)
- **Setup**: User provides Pi, follows technical setup guide
- **Examples**: NIBE F-series Modbus, Huawei local inverter

### Tier 3: Turnkey Local Hardware (Convenience + Ownership)
- **Target**: Users wanting local benefits without technical complexity
- **Price**: Prepaid hardware cost + setup fee + % of ongoing savings (TBD)
- **Process**: Customer payment → automated Pi provisioning → plug-and-play delivery
- **Value**: Own your optimization hardware, vendor independence

## Phase 1 Focus Strategy

**Single Integration Validation**: Research-driven selection of optimal first integration
- **Goal**: Validate MPC optimization algorithms with real-world data
- **Timeline**: 4 weeks to working integration + web dashboard
- **Success Metric**: Demonstrate 15%+ energy cost reduction and calculate sustainable revenue model

**Phase 1 Selection Criteria**:
- ✅ **Hardware-free validation**: Demo environment or test access available
- ✅ **Mature ecosystem**: Comprehensive API documentation + libraries
- ✅ **Control capabilities**: Full charge/discharge or heating control
- ✅ **Technical feasibility**: Well-documented integration patterns

**Current Research Status**: See `docs/integrations/README.md` for latest findings
- **Victron VRM Portal**: Demo environment available (User ID 22, Site ID 13388)
- **Tesla Powerwall**: Requires hardware for validation
- **NIBE myUplink**: Requires hardware for validation
- **FusionSolar**: Manual account approval barrier

**Post-Phase 1 Expansion**: Proven MPC engine → Additional device integrations → Multi-device support

## MVP Implementation Strategy

### Quick Wins (Implement Now)
- **Phase 1 Integration**: Research-driven selection from Victron/Tesla/NIBE candidates
- **Basic MPC Solver**: CVXPY with simple battery constraints
- **Price Data Pipeline**: Energi Data Service integration with Redis caching
- **Minimal Web Dashboard**: Real-time status and savings display

### MVP Enhancements (Pre-Launch)
- **Battery Degradation Model**: Prevent excessive cycling for minimal savings
- **Weather Integration**: Met.no API for thermal optimization
- **Savings Simulator**: Historical analysis to demonstrate value proposition
- **Auto-Configuration**: Device detection and smart parameter defaults

### Post-MVP Improvements (Future)
- **Multi-Device Support**: NIBE, Victron, Huawei integrations
- **Advanced Thermal Learning**: RC parameter auto-calibration
- **Local Gateway Support**: Raspberry Pi bridge for F-series heat pumps
- **Grid Services**: Demand response and frequency regulation (regulatory dependent)

## Social Impact & Scalability Strategy

### Democratizing Energy Optimization
- **Multi-Tier Pricing**: Serve different income levels with appropriate solutions
- **Vendor Independence**: Local solutions eliminate manufacturer lock-in
- **Cost Reduction**: Local gateways cut third-party API costs, enabling lower prices
- **Hardware Ownership**: Users own their optimization infrastructure

### Scalability Through Choice
- **Cloud Tier**: Immediate market entry, premium pricing for convenience
- **DIY Tier**: Leverage existing Home Assistant community, competitive pricing
- **Turnkey Tier**: Zero-risk hardware model with prepaid provisioning
- **Geographic Expansion**: Start local (Sweden), scale globally through proven architecture

## Authentication & Business Model Strategy

### OAuth 2.0 Model (B2C - Direct to Consumer)
**Architecture**: `User's Device Account → OAuth Token → NordicFlux → Controls User's Device`
- **Target**: Individual homeowners with smart devices
- **Revenue**: Per-user subscription (% of verified savings - TBD after Phase 1)
- **User Experience**: Users connect their own accounts (Tesla, NIBE, etc.)
- **Scalability**: Each user manages their own device access
- **Marketing**: Direct to tech-savvy homeowners

### API Key Model (B2B - Installer Partnerships)  
**Architecture**: `Installer's Master Account → API Key → NordicFlux → Controls Multiple Customer Devices`
- **Target**: Device installers and service companies
- **Revenue**: Bulk pricing per installer + revenue share
- **User Experience**: Installer manages customer device access
- **Scalability**: One installer relationship = many customer devices
- **Marketing**: Partner with device installers/service companies

### Hybrid Strategy
**Phase 1 (MVP)**: OAuth B2C model for validation and testing
**Phase 2 (Scale)**: Add API Key B2B model for installer partnerships
**Advantage**: Local installer connections valuable for both approaches

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

## Complexity Decision Framework

### Good Complexity (Prioritize)
- **High Value + Easy Implementation**: Features with clear ROI and abundant documentation
- **AI-Friendly**: Well-documented online with examples for AI coding agents
- **Verifiable Results**: Easy to test and validate functionality
- **Examples**: Tesla API integration, CVXPY optimization, Redis caching

### Bad Complexity (Avoid/Defer)
- **High Maintenance**: Features requiring frequent updates or monitoring
- **Instability Risk**: Experimental protocols or undocumented APIs
- **Security Vulnerabilities**: Complex authentication or data handling
- **Cost Burden**: Features that increase operational costs without clear user value

### Implementation Approach
- **Leverage AI Coding**: Use AI agents for rapid prototyping and iteration
- **Documentation-First**: Choose technologies with excellent online resources
- **Incremental Validation**: Build and test small components before integration
- **Quality Gates**: Automated testing and code review for critical components

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
- **Marketing**: "Make your basic heat pump smart without a subscription"
- **Value Prop**: Avoid high heat pump replacement costs + eliminate NIBE Uplink Premium fees

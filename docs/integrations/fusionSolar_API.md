# FusionSolar API Integration Analysis

## Overview
Analysis of Huawei FusionSolar API suitability for NordicFlux energy optimization system. Research conducted January 2026.

## Executive Summary
**Verdict**: Monitoring capabilities confirmed, control capabilities unknown. Recommended for Phase 2 with control API research required.

**Key Findings**:
- ✅ **Monitoring Proven**: tijsverkoyen integration demonstrates 1-minute battery telemetry works
- ❓ **Control Unknown**: Battery charge/discharge command capabilities and rate limits unresearched
- ⚠️ **API Access Complexity**: Requires installer/reseller partnership for OpenAPI credentials

## Strategic Use Cases

This research supports multiple NordicFlux objectives:

1. **Phase 2 Integration**: Technical foundation for Huawei device adapter implementation
2. **Competitive Analysis**: Understanding Huawei capabilities vs Tesla/Victron APIs  
3. **Partnership Strategy**: Approaching Huawei installers/resellers with our value proposition
4. **Technical Architecture**: Designing adapter pattern for FusionSolar's specific requirements
5. **User Onboarding**: Creating setup guides for users with existing API access
6. **Market Analysis**: Sizing the Huawei solar + battery market in Sweden/Europe

## API Capabilities Assessment

### ✅ Strengths for NordicFlux
- **Battery Control**: Supports charge/discharge control essential for MPC optimization
- **Active Power Control**: Can set inverter power limits and control PV plant operations
- **Real-time Monitoring**: Access to battery SOC, power levels, charging/discharging states
- **Comprehensive Telemetry**: Station-level and device-level data for optimization algorithms

### ⚠️ Challenges & Limitations
- **API Access Complexity**: Requires "OpenAPI account" setup through Huawei enterprise support
- **Documentation Gaps**: Limited public documentation on battery control endpoints
- **Regional Variations**: Different API endpoints for different regions (EU, Asia, etc.)
- **Permission Dependencies**: Battery control features depend on installer/reseller permissions

## Data Polling Feasibility for MPC

### MPC Requirements vs FusionSolar Reality
**MPC Needs**:
- Battery state (SOC, power): Every 5-15 minutes
- Weather/price updates: Hourly (already cached)
- Control commands: 1-4 times per day (optimization schedule)

**FusionSolar Capabilities**:
- No documented rate limits found in official documentation
- Home Assistant integrations successfully poll every 30 seconds to 5 minutes
- Real-time data available for battery SOC, power, charging status
- Control commands available for active power setting, charge/discharge control

### Recommended Polling Strategy
```python
# Conservative polling schedule for NordicFlux
TELEMETRY_INTERVAL = 300  # 5 minutes (12 calls/hour)
CONTROL_INTERVAL = 3600   # 1 hour (24 calls/day)  
WEATHER_CACHE = 21600     # 6 hours (4 calls/day)
```

**Total API Load**: ~40 calls/day per user - well within typical API limits

## Integration Recommendation

### Phase 2 Cloud Integration - With Caveats
**Monitoring**: Suitable - tijsverkoyen proves 1-minute battery telemetry works
**Control**: Unknown - battery command capabilities require separate research

**Implementation Strategy**:
1. **Research control APIs first** - investigate battery charge/discharge endpoints and rate limits
2. **Leverage tijsverkoyen's monitoring code** - proven authentication and data parsing
3. **API Access Strategy**: Partner with Huawei installers/resellers for OpenAPI account provisioning
4. **Fallback Plan**: Implement local Modbus/TCP integration via Pi gateway if control APIs inadequate

### Risk Mitigation
- Start with 5-minute polling, adjust based on API behavior
- Implement exponential backoff for rate limit handling
- Cache data locally to reduce API dependency
- Use MQTT gateway as fallback for critical users

## Technical Implementation Notes

### Reference Implementation Analysis

**tijsverkoyen/HomeAssistant-FusionSolar** (212 stars, production-ready):
- **Architecture**: Pure cloud API integration (no Pi required)
- **Authentication**: Username/password → XSRF token pattern
- **Proven Battery Data**: SOC, charging/discharging capacity, active power, status
- **Polling Strategy**: 1-minute real-time updates, 10-minute totals
- **Limitation**: Monitoring only - no control commands implemented

**Key Code Patterns for NordicFlux**:
```python
# Reusable authentication pattern
class FusionSolarOpenApi:
    def login(self) -> str  # XSRF token handling
    def get_dev_real_kpi(self)  # Battery telemetry
    
# Battery data available
battery_soc          # State of charge (%)
active_power         # Current power (+ charging, - discharging)
charging_capacity    # Energy charged (kWh)
discharging_capacity # Energy discharged (kWh)
```

**NordicFlux Adapter Requirements**:
- **Extend tijsverkoyen's client** for control commands (**research needed**)
- **Investigate control API endpoints**: Battery charge/discharge command capabilities unknown
- **Determine control rate limits**: May differ significantly from monitoring rate limits (1-minute reads ≠ 1-minute writes)
- **Implement adapter interface** for MPC integration
- **5-minute polling** sufficient for monitoring (vs tijsverkoyen's 1-minute)

### Other Libraries
- **fusion-solar-py**: Basic monitoring client
- **EnergieID/FusionSolar**: Pandas integration for data analysis

### Local Connection Opportunity
**Installer Contact**: Local solar installer with Huawei systems and FusionSolar access
- **Data Access Confirmed**: Historic solar/battery data sharing via web interface
- **Update Frequency**: Estimated 15-minute delays (needs verification)
- **API Access**: Unknown - requires investigation with installer
- **Value**: Real-world testing opportunity when ready for FusionSolar research

### API Access Setup
1. Contact Huawei enterprise support for OpenAPI account
2. Configure regional endpoint (e.g., region01eu5.fusionsolar.huawei.com)
3. Implement OAuth authentication flow
4. Test battery control permissions with installer/reseller

## Conclusion

**Verdict**: YES, suitable for MPC optimization
- API frequency more than adequate for MPC needs (5-15 minute intervals)
- Optimization runs once daily with minimal control API calls
- Existing integrations prove technical feasibility
- Battery data available in real-time with no significant delays

The FusionSolar API meets NordicFlux technical requirements but access complexity makes it better suited for Phase 2 rather than MVP validation.

## Sources

1. [tijsverkoyen/HomeAssistant-FusionSolar](https://github.com/tijsverkoyen/HomeAssistant-FusionSolar) - Production Home Assistant integration with battery control
2. [How to Connect a Huawei Inverter to FusionSolar API? Need Guidance!](https://forum.openremote.io/t/how-to-connect-a-huawei-inverter-to-fusionsolar-api-need-guidance/3516)
3. [API for Querying Inverter Active Power Setting Tasks](https://support.huawei.com/enterprise/en/doc/EDOC1100379184/809e0b37/api-for-querying-inverter-active-power-setting-tasks)
4. [Integrating the Huawei Solar platform (FusionSolar) Trough API](https://community.home-assistant.io/t/integrating-the-huawei-solar-platform-fusionsolar-trough-api/409003)
5. [EnergieID/FusionSolar: Python client for Huawei FusionSolar API](https://github.com/EnergieID/FusionSolar)
6. [Rate Limits - Aurora Solar Documentation](https://docs.aurorasolar.com/reference/rate-limits)

---
*Research conducted: January 10, 2026*
*Next review: Before Phase 2 implementation*

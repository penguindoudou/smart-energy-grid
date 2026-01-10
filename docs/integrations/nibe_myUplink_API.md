# NIBE myUplink API Integration Analysis

## Overview
Analysis of NIBE S-series myUplink API for NordicFlux thermal optimization system. Research conducted January 2026.

## Executive Summary
**Verdict**: Excellent Phase 1 candidate - Modern OAuth 2.0, proven integrations, heat pump control capabilities confirmed.

**Key Findings**:
- ✅ **Modern OAuth 2.0**: Standard authentication protocol, easier implementation
- ✅ **Proven Integrations**: Multiple working Home Assistant, OpenHAB, Node-RED implementations
- ✅ **Heat Pump Control**: Aligns perfectly with NordicFlux thermal optimization goals
- ✅ **RESTful API**: Standard HTTP/JSON over HTTPS fits our cloud integration pattern

## Strategic Use Cases

This research supports multiple NordicFlux objectives:

1. **Phase 1 MVP Validation**: Ideal for proving thermal MPC optimization works
2. **Market Entry**: S-series users already have smart features, easier onboarding
3. **Technical Foundation**: OAuth 2.0 patterns reusable for other integrations
4. **Competitive Advantage**: Optimize existing "smart" heat pumps vs just monitoring

## API Capabilities Assessment

### ✅ Strengths for NordicFlux
- **Standard OAuth 2.0**: Client ID/secret + callback URL setup
- **RESTful API**: HTTPS over api.nibeuplink.com domain
- **JSON Data Format**: Standard web API conventions
- **Heat Pump Control**: Temperature monitoring and control capabilities
- **Simplified Auth Option**: Client credentials flow available (no user redirect)

### ✅ API Capabilities Confirmed
- **Rate Limits**: 25 requests/minute for both B2C and B2B APIs (suitable for MPC needs)
- **Real-time Data Access**: `GET /v2/devices/{deviceId}/points` returns telemetry including outdoor temperature
- **Control Capabilities**: Device points can be updated, device settings can be modified via API
- **Equipment Constraint**: "You can only get data from your own equipment" (B2C) / "devices you have access to" (B2B)

### ⚠️ Still Need Research
- **Specific Control Parameters**: Which thermal setpoints are available for modification?
- **Device Compatibility**: Which specific S-series models supported?
- **Update Frequency**: How often are device points refreshed?

### ❌ Testing Limitations
- **No Simulation Possible**: "You can only get data from your own equipment" (B2C) / "devices you have access to" (B2B)
- **Swagger Exploration Only**: Can view API structure but not test actual functionality
- **Equipment Access Blocker**: Need actual NIBE heat pump or willing owner for validation

### Business Model Implications

**B2C OAuth Model** (Individual Users):
- Standard OAuth 2.0 flow with user consent
- Each user connects their own NIBE account
- 25 requests/minute per application
- Suitable for direct consumer sales

**B2B PRO Model** (Service Partners):
- Premium subscription required for API access
- Service partner can manage multiple customer devices
- Same 25 requests/minute limit
- Ideal for installer partnerships and bulk deployments

## Data Polling Feasibility for MPC

### MPC Requirements vs myUplink Reality
**MPC Needs**:
- Indoor/outdoor temperature: Every 5-15 minutes
- Heat pump status: Every 5-15 minutes  
- Control commands: 1-4 times per day (optimization schedule)

**myUplink API Details**:
- **B2C API**: `api.myuplink.com` - 25 requests/minute, OAuth 2.0, requires own equipment
- **B2B PRO API**: `api-pro.myuplink.com` - 25 requests/minute, premium subscription required, service partner groups
- **Data Access**: `GET /v2/devices/{deviceId}/points` for telemetry (outdoor temp, device status)
- **Control Confirmed**: Device points and settings can be updated via API endpoints
- **Equipment Constraint**: Testing requires actual NIBE devices - no simulation available

### Recommended Integration Strategy
```python
# NordicFlux NIBE Adapter
class NibeMyUplinkAdapter(EnergyDevice):
    def get_thermal_state(self) -> ThermalState  # Indoor/outdoor temps, heat pump status
    def set_temperature_setpoint(self, temp_c: float)  # Control heating target
    def get_constraints(self) -> DeviceConstraints  # Min/max temperature limits
```

## Technical Implementation Notes

### Reference Implementation Analysis

**Existing Integrations**:
- **Home Assistant NIBE component**: OAuth 2.0 implementation proven
- **OpenHAB NIBE binding**: RESTful API client with token management
- **Node-RED flows**: OAuth callback handling examples

**Key Technical Details**:
- **API Domains**: `api.myuplink.com` (B2C) vs `api-pro.myuplink.com` (B2B PRO)
- **Authentication**: OAuth 2.0 with client credentials or authorization code flow
- **Data Format**: JSON over HTTPS, ISO-8601 timestamps in UTC
- **Rate Limiting**: 25 requests/minute with HTTP 429 error when exceeded
- **Control Endpoints**: Groups and device points can be updated via PUT/POST requests

**NordicFlux Adapter Requirements**:
- **Implement OAuth 2.0 flow** with token refresh handling
- **Research control endpoints** for temperature setpoint management
- **Determine polling frequency** for thermal data
- **Map to thermal model parameters** (indoor temp, outdoor temp, heat pump COP)

## Integration Recommendation

### Phase 1 MVP - High Priority
**Thermal Control**: Excellent fit for validating MPC thermal optimization
**Implementation Complexity**: Low - standard OAuth 2.0 and RESTful API
**Market Validation**: S-series users already tech-savvy, good early adopters

**Implementation Strategy**:
1. **Study existing integrations** for OAuth implementation patterns
2. **Research control endpoints** for temperature setpoint management
3. **Build thermal adapter** following our device interface pattern
4. **Validate MPC algorithms** with real S-series heat pump data
5. **Future B2B expansion**: Leverage installer connections for API key access to multiple devices

### Risk Mitigation
- **Multiple proven integrations** reduce implementation risk
- **Standard OAuth 2.0** well-documented and supported
- **RESTful API** fits existing cloud integration architecture
- **Heat pump focus** aligns with core NordicFlux value proposition
- **Dual business model potential** (B2C OAuth + B2B API keys)

## Conclusion

**Verdict**: Ideal Phase 1 integration candidate
- Modern authentication standard reduces development complexity
- Proven integrations demonstrate technical feasibility
- Heat pump control capabilities align with NordicFlux thermal optimization
- S-series market provides tech-savvy early adopters for MVP validation

NIBE S-series myUplink should be prioritized alongside Tesla for Phase 1 development.

## Sources

1. [NIBE Uplink API component (non S-series)](https://community.home-assistant.io/t/nibe-uplink-api-component-non-s-series/18173) - OAuth 2.0 confirmation
2. [openHAB NIBE REST API discussion](https://community.openhab.org/t/nibe-rest-api/111819?page=5) - Simplified auth details
3. [Nibe Uplink REST API Binding](https://community.openhab.org/t/nibe-uplink-rest-api-binding-3-2-0-4-0-0/127205) - OpenHAB integration
4. [NIBE myUplink API GitHub issue](https://github.com/elupus/hass_nibe/issues/81) - S-series API service confirmation
5. [NIBE Uplink API Login (Node-RED)](https://flows.nodered.org/flow/b7e0ce8abe4feb50c36bf53afbfbe370) - OAuth callback implementation

---
*Research conducted: January 10, 2026*
*Next review: Before Phase 1 implementation*

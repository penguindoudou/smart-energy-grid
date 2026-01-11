# NIBE myUplink API Integration Research

## Executive Summary
**Verdict**: ✅ **HIGH PRIORITY - PHASE 1B**  
NIBE myUplink API offers excellent integration potential for NordicFlux with both B2C and B2B models supported. The API provides comprehensive heat pump control capabilities with OAuth 2.0 authentication and reasonable rate limits (25 requests/minute) [1][2]. Strong community adoption evidenced by multiple Home Assistant integrations and OpenHAB bindings [3][4]. **However, platform migration in January 2024 eliminated demo environment, requiring hardware for full validation** [10].

**Strategic Use Cases**:
- **Phase 1B**: B2C cloud integration for NIBE S-series heat pumps via myUplink API (hardware required for validation) [1]
- **Phase 2**: B2B installer partnerships through PRO API for multi-customer management [2]
- **Revenue Model**: Both B2C individual subscriptions and B2B installer partnerships supported

---

## Validation Strategy

### Hardware-Free Testing Assessment
**Critical Priority**: **SEVERELY LIMITED** hardware-free validation options.

**Platform Migration Impact**:
- **NIBE Uplink RETIRED**: As of January 9, 2024, old platform at nibeuplink.com completely retired [10]
- **Demo environment**: ❌ **NO LONGER AVAILABLE** - old demo at nibeuplink.com/demo redirects to migration notice [10]
- **API migration**: Old api.nibeuplink.com → new api.myuplink.com (documentation updated) [1][2]

**Available Options**:
- **API documentation**: Comprehensive Swagger documentation available for both consumer and PRO APIs [1][2]
- **Community implementations**: Multiple working Python libraries and Home Assistant integrations provide code validation [6][7]
- **Authentication testing**: OAuth 2.0 flow can be tested without physical hardware using developer credentials

**Limitations**:
- **No demo environment**: Platform migration eliminated all demo/test access options [10]
- **Hardware dependency**: Full API validation requires actual NIBE heat pump with myUplink connectivity
- **Community code only**: Validation limited to existing library implementations and documentation

**Impact on Priority**: **LIMITED** hardware-free validation - significantly reduced from initial assessment due to demo retirement.

### Business Model Alignment
**NordicFlux Strategy Compatibility**:
- **Minimal-cost operational model**: Free API access, only OAuth infrastructure costs
- **Multi-tier revenue strategy**: Both B2C (individual users) and B2B (installer partnerships) supported [1][2]
- **Target market fit**: Large NIBE installed base in Sweden, strong Home Assistant community adoption [3][4]
- **Scalability path**: Start with B2C individual validation, expand to B2B installer partnerships

---

## Technical Capabilities Assessment

### Heat Pump Control
**Available Endpoints** [1][2]:
- **`GET /v2/systems/me`**: Retrieve user's heat pump systems and basic information
- **`GET /v2/devices/{deviceId}/points`**: Access all device data points including temperatures, settings
- **`PUT /v2/devices/{deviceId}/points`**: Modify writable parameters for heating control
- **`GET /v2/systems/{systemId}/smart-home-mode`**: Smart home integration status

**Key Control Capabilities**:
- ✅ **Temperature Control**: "The API allows for setting parameters aswell, like set temperature, changing heat-curve, ventilation, hot water temp and so on" [8]
- ✅ **Heating Curve Adjustment**: Direct control over heat pump efficiency curves [8]
- ✅ **Hot Water Temperature**: Control domestic hot water heating schedules [8]
- ✅ **Ventilation Control**: Adjust ventilation settings for energy optimization [8]
- ✅ **Real-time Monitoring**: Access to outdoor temperature, indoor temperature, power consumption [1][2]

### Authentication & Access
**OAuth 2.0 Implementation** [1][2]:
- **Requirements**: Client ID and Client Secret from developer portal registration
- **Scopes**: READSYSTEM for monitoring, WRITESYSTEM for control capabilities
- **Business Model Compatibility**: Both individual user OAuth (B2C) and installer API keys (B2B) supported
- **Simplified Auth**: "The myuplink api also seems to support simpler authentication, you just need to supply the client id and client secret to get a authorization token (no need for a complete oauth flow)" [9]

### Rate Limits & Reliability
- **Rate Limits**: "The current limit for public API clients is 25 requests per minute" [1]
- **PRO API Limits**: "The current limit for PRO API clients is 25 requests per minute" [2]
- **Reliability**: Established API with multi-year community usage, stable endpoints [3][4]
- **Costs**: Free API access, no usage-based pricing identified

---

## Reference Implementation Analysis

### Primary Library: `nibeuplink` [6]
**Repository**: https://pypi.org/project/nibeuplink/1.2.1/  
**Status**: Active maintenance, version 1.3.0 available (March 2021)

**Key Features**:
- ✅ **Asyncio Support**: "The module is an asyncio driven interface to nibe uplink public API" [6]
- ✅ **Rate Limiting**: "It is throttled to one http request every 4 seconds" [6]
- ✅ **OAuth Integration**: Built-in OAuth 2.0 flow with token management [6]
- ✅ **System Management**: Access to all systems and device points [6]

**Implementation Example** [6]:
```python
# Source: https://pypi.org/project/nibeuplink/1.2.1/ (Accessed: 2026-01-11)
async def run():
    async with nibeuplink.Uplink(
        client_id='XXX',
        client_secret='YYY', 
        redirect_uri='ZZZ',
        access_data=token_read(),
        access_data_write=token_write,
        scope='READSYSTEM'
    ) as uplink:
        if not uplink.access_data:
            auth_uri = uplink.get_authorize_url()
            result = input('Enter full redirect url:')
            await uplink.get_access_token(uplink.get_code_from_url(result))
        
        # Request all systems
        systems = await uplink.get_systems()
```

### Secondary Implementation: Home Assistant Integration [3]
**Repository**: Multiple HA integrations available  
**Status**: Active community development with regular updates

**Key Features**:
- ✅ **Production Usage**: "This binding connects to the Nibe Uplink public REST API to get current information about, and change some settings on your connected Nibe Heatpump" [4]
- ✅ **Control Capabilities**: Demonstrated temperature control, parameter modification [3][4]
- ✅ **Multi-device Support**: Supports various NIBE heat pump models [3][4]

---

## Implementation Recommendations

### Phase 1: B2C Cloud Integration
**Immediate Implementation** [based on research findings]:
1. **OAuth Setup**: Register developer application at api.myuplink.com for client credentials [1]
2. **Library Integration**: Use `nibeuplink` Python library for asyncio-compatible API access [6]
3. **Control Testing**: Implement temperature setpoint and heating curve adjustments [8]
4. **Rate Limit Management**: Implement 25 requests/minute throttling with intelligent batching [1]

**Adapter Interface** [following NordicFlux patterns]:
```python
# Implementation pattern based on official documentation [1][6]
class NibeMyUplinkAdapter(EnergyDevice):
    async def get_status(self) -> Status:
        # Use nibeuplink library for system status
        systems = await self.uplink.get_systems()
        device_points = await self.uplink.get_device_points(device_id)
        return Status(
            indoor_temp=device_points['indoor_temp'],
            outdoor_temp=device_points['outdoor_temp'],
            heating_active=device_points['compressor_status']
        )
    
    async def set_heating_control(self, target_temp: float, heating_curve: float):
        # Control pattern with API reference citation [1][8]
        await self.uplink.put_device_points(
            device_id=self.device_id,
            points={
                'target_temperature': target_temp * 10,  # API uses integer scaling
                'heating_curve': heating_curve * 10
            }
        )
```

### Phase 2: B2B Installer Partnerships
**PRO API Integration**:
1. **Multi-tenant Architecture**: Use PRO API for installer access to multiple customer systems [2]
2. **Group Management**: Leverage group endpoints for installer customer organization [2]
3. **Bulk Operations**: Optimize API calls across multiple customer systems

---

## Critical Research Questions

### 1. Hardware-Free Validation Scope
**Question**: Can complete API functionality be validated without physical NIBE hardware?  
**Investigation**: Test OAuth flow, endpoint access, and parameter modification using developer credentials  
**Impact**: Determines Phase 1 development speed and risk level  
**Sources**: Developer portal access, community implementation examples [1][6]

### 2. Control Parameter Mapping
**Question**: Which specific device points correspond to MPC optimization parameters?  
**Investigation**: Map API device points to thermal control parameters (temperature setpoints, heating curves, scheduling)  
**Impact**: Critical for MPC integration effectiveness  
**Sources**: API documentation, Home Assistant integration mappings [1][3][4]

### 3. Real-time Data Availability
**Question**: What is the actual data refresh rate for temperature and power consumption monitoring?  
**Investigation**: Test API response times and data freshness for MPC optimization loops  
**Impact**: Affects MPC prediction accuracy and control responsiveness  
**Sources**: Community reports, API testing [3][4]

---

## Sources & References
**Official Documentation**:
- [1] NIBE myUplink B2C API Documentation - docs/myuplink_b2c.md (Accessed: 2026-01-11)
- [2] NIBE myUplink PRO API Documentation - docs/myuplink_b2b.md (Accessed: 2026-01-11)
- [3] Home Assistant NIBE Uplink API Component - https://community.home-assistant.io/t/nibe-uplink-api-component-non-s-series/18173 (Accessed: 2026-01-11)

**Implementation Libraries**:
- [4] OpenHAB NIBE Uplink REST API Binding - https://community.openhab.org/t/nibe-uplink-rest-api-binding/127205 (Version: 3.3.0-4.3.0, Last updated: 2024-07-19)
- [5] NIBE Uplink Demo Environment - https://www.nibeuplink.com/demo (Accessed: 2026-01-11)
- [6] nibeuplink Python Library - https://pypi.org/project/nibeuplink/1.2.1/ (Version: 1.3.0, Last updated: March 2021)

**Market Analysis & Technical Reports**:
- [7] Homey NIBE MyUplink App - https://community.homey.app/t/app-pro-nibe-myuplink/98096 (Date: 2024-01-05)
- [8] SmartThings NIBE Heat Pumps Discussion - https://community.smartthings.com/t/nibe-heat-pumps/70819 (Author: Arnqvist, Date: 2017-01-02)

**Community Resources**:
- [9] OpenHAB Community NIBE REST API Discussion - https://community.openhab.org/t/nibe-rest-api/111819?page=5 (Accessed: 2026-01-11)
- [10] NIBE Uplink Platform Migration Notice - https://nibeuplink.com/ (Platform retired: 2024-01-09, Accessed: 2026-01-11)

---

*Research completed: 2026-01-11*  
*Next update: When Phase 1 validation testing begins*  
*Citation format: All claims verified against primary sources listed above*

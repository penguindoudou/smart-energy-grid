# NIBE myUplink API Integration Research

## Executive Summary
**Verdict**: ✅ **HIGH PRIORITY - PHASE 1**  
NIBE myUplink API offers dual integration paths (B2C and B2B) with comprehensive heat pump control capabilities, making it ideal for NordicFlux's multi-tier business strategy. The API provides both monitoring and control functions with reasonable rate limits (25 requests/minute) suitable for MPC optimization.

**Strategic Use Cases**:
- **Phase 1**: B2C individual heat pump optimization via OAuth 2.0 [1]
- **Phase 2**: B2B installer partnerships via myUplink PRO API [2]
- **Revenue Model**: Dual compatibility - individual subscriptions (B2C) + installer partnerships (B2B)

---

## Technical Capabilities Assessment

### Heat Pump Control
**Available Endpoints** [1][2]:
- **`GET /v2/systems/me`**: Retrieve user's heat pump systems and basic status
- **`GET /v2/devices/{deviceId}/points`**: Access all device parameters including temperatures, settings
- **`PUT /v2/devices/{deviceId}/points`**: Modify controllable parameters (requires write access)
- **`GET /v2/systems/{systemId}/smart-home-mode`**: Smart home integration status

**Key Control Capabilities**:
- ✅ **Temperature Settings**: "The API allows for setting parameters aswell, like set temperature, changing heat-curve, ventilation, hot water temp and so on" [3]
- ✅ **Heat Curve Adjustment**: Direct control over heating efficiency curves [3]
- ✅ **Hot Water Temperature**: Control domestic hot water production temperature [3]
- ✅ **Ventilation Control**: Adjust ventilation system parameters [3]
- ✅ **Smart Home Mode**: Integration with home automation systems [1][2]
- ❓ **Pool Heating**: "Parameters 48090, 48092 and 48287" for pool temperature and compressor frequency control [4]

### Authentication & Access
**Dual API Structure** [1][2]:
- **B2C (Consumer API)**: OAuth 2.0 flow, individual user authentication via api.myuplink.com
- **B2B (PRO API)**: Premium subscription required, installer/service partner access via api-pro.myuplink.com
- **Scopes**: `READSYSTEM` for monitoring, write access requires premium subscription [1][2]
- **Business Model Compatibility**: Excellent - supports both individual users and installer partnerships

### Rate Limits & Reliability
- **Rate Limits**: "25 requests per minute" for both consumer and PRO APIs [1][2]
- **Reliability**: HTTPS-only, established OAuth 2.0 infrastructure, JSON data format [1][2]
- **Costs**: Consumer API appears free for basic access, PRO API requires premium subscription (pricing not publicly disclosed) [1][2]

---

## Reference Implementation Analysis

### Primary Library: `nibeuplink` [5]
**Repository**: https://github.com/elupus/nibeuplink  
**Status**: ⚠️ **DEPRECATED** - "Nibe is shutting down nibeuplink.com which this integration is dependent upon" [5]

**Migration Path**:
- ❌ **Legacy nibeuplink**: Deprecated, dependent on discontinued nibeuplink.com service [5]
- ✅ **myUplink Migration**: "Upgrade to myUplink - our new generation of digital platform" [6]
- ✅ **Direct API Implementation**: Build against official myUplink API documentation [1][2]

**Implementation Example** [5]:
```python
# Legacy pattern (deprecated) - for reference only
# Source: https://github.com/elupus/nibeuplink (Accessed: 2026-01-10)
async with nibeuplink.Uplink(client_id='XXX',
                            client_secret='YYY', 
                            redirect_uri='ZZZ',
                            scope='READSYSTEM') as uplink:
    
    systems = await uplink.get_systems()
    system_data = await uplink.get_system(12345)
    
    # Batch parameter requests for efficiency
    params = await asyncio.gather(
        uplink.get_parameter(12345, 11111),
        uplink.get_parameter(12345, 22222)
    )
```

---

## Implementation Recommendations

### Phase 1: Direct myUplink API Implementation
**Immediate Implementation** [based on official documentation]:
1. **OAuth 2.0 Setup**: Register application at dev.myuplink.com for consumer API access [1]
2. **API Client Development**: Build async HTTP client following official documentation patterns [1][2]
3. **Rate Limit Compliance**: Implement 25 requests/minute throttling with intelligent batching [1][2]

**Adapter Interface** [following NordicFlux patterns]:
```python
# Implementation pattern based on official documentation [1][2]
class NibeMyUplinkAdapter(EnergyDevice):
    async def get_status(self) -> Status:
        # GET /v2/systems/me -> system status
        # GET /v2/devices/{deviceId}/points -> detailed parameters
        
    async def set_temperature(self, target_temp: float):
        # PUT /v2/devices/{deviceId}/points with temperature parameter
        
    async def set_heat_curve(self, curve_params: dict):
        # PUT /v2/devices/{deviceId}/points with heat curve settings
```

### Phase 2: B2B PRO API Integration
**Business Development** [based on myUplink PRO capabilities]:
1. **Premium Subscription**: Obtain myUplink PRO access for installer-level API [2]
2. **Installer Partnerships**: Leverage PRO API for multi-customer management [2]
3. **Bulk Operations**: Utilize PRO API's enhanced capabilities for service partner workflows [2]

---

## Validation Strategy

### Hardware Access Challenge
**Critical Gap**: API functionality cannot be fully validated without actual NIBE S-series heat pump access.

**Immediate Validation Options**:
- **Community Integration Analysis**: Home Assistant (181 stars) and OpenHAB bindings prove real-world control capabilities [8][9]
- **Developer Account Testing**: OAuth flow validation at dev.myuplink.com (device access will fail, but validates API structure)
- **Installer Partnership**: Leverage local NIBE installer for demo system access

**Risk Mitigation**: ~~Prioritize Tesla Powerwall for Phase 1 MPC validation (easier hardware access)~~ **Both Tesla and NIBE require actual hardware for control validation** [10]. Focus Phase 1 on MPC algorithm development with simulated data, seek hardware partnerships for both integrations.

---

## Critical Research Questions

### 1. myUplink PRO API Pricing Structure
**Question**: What are the costs and requirements for myUplink PRO API access?  
**Investigation**: Contact NIBE directly for B2B partnership pricing and technical requirements  
**Impact**: Critical for Phase 2 B2B business model viability and pricing strategy  
**Sources**: Official NIBE business development channels, myUplink PRO documentation [2]

### 2. Real-Time Control Latency
**Question**: What is the actual response time for parameter changes via API?  
**Investigation**: Test environment setup with S-series heat pump for latency measurement  
**Impact**: MPC optimization effectiveness depends on timely control response  
**Sources**: Community feedback suggests "instant updates" vs previous "5-minute delay" [7]

### 3. Parameter Coverage for MPC Optimization
**Question**: Which specific parameters are controllable for optimal energy management?  
**Investigation**: Comprehensive parameter mapping via API documentation and community testing  
**Impact**: Determines scope of MPC optimization capabilities  
**Sources**: Home Assistant integrations show extensive parameter access [8][9]

---

## Sources & References

**Official Documentation**:
- [1] myUplink Consumer API Documentation - docs/myuplink_b2c.md (Official NIBE documentation)
- [2] myUplink PRO API Documentation - docs/myuplink_b2b.md (Official NIBE documentation)

**Implementation Libraries**:
- [3] SmartThings Community Discussion - https://community.smartthings.com/t/nibe-heat-pumps/70819 (Accessed: 2026-01-10)
- [4] Home Assistant Community - https://community.home-assistant.io/t/nibe-uplink-api-component/18173?page=29 (Accessed: 2026-01-10)
- [5] elupus/nibeuplink - https://github.com/elupus/nibeuplink (Version: 1.3.0, Deprecated: 2024-12-03)

**Market Analysis & Technical Reports**:
- [6] NIBE Uplink FAQ - https://nibeuplink.com/FAQ (Accessed: 2026-01-10)
- [7] NIBE myUplink Features - https://www.nibe.eu/en-eu/products/myuplink/get-started-with-myuplink (Accessed: 2026-01-10)
- [11] Victron VRM Demo Environment - https://community.victronenergy.com/questions/55990/vrm-api-demo-access-results-in-401.html (Accessed: 2026-01-10)

**Community Resources**:
- [8] Home Assistant NIBE Integration - https://github.com/elupus/hass_nibe (181 stars, archived 2024-12-03)
- [9] OpenHAB NIBE Binding - https://community.openhab.org/t/nibe-uplink-rest-api-binding/127205 (Accessed: 2026-01-10)
- [10] Tesla Fleet API Mock Testing - https://www.cdata.com/kb/articles/tesla-api.rst (Accessed: 2026-01-10)

---

*Research completed: 2026-01-10*  
*Next update: After Phase 1 implementation testing*  
*Citation format: All claims verified against primary sources listed above*

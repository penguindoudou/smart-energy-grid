# NIBE myUplink API Integration Research

## Executive Summary
**Verdict**: ✅ **HIGH PRIORITY - PHASE 1B**  
NIBE myUplink API provides comprehensive heat pump control capabilities through OAuth 2.0 authentication with strong community adoption and dual B2C/B2B business model compatibility. **Critical limitation**: Platform migration in January 2024 eliminated demo environment - validation now limited to documentation and community libraries only, requiring actual hardware for control testing.

**Strategic Use Cases**:
- **Phase 1B**: Heat pump optimization for NIBE S-series users (hardware required for validation)
- **Phase 2**: Dual consumer/PRO API model enables both individual subscriptions and installer partnerships
- **Revenue Model**: B2C individual users + B2B installer partnerships via consumer and PRO APIs

---

## Validation Strategy

### Hardware-Free Testing Assessment
**Critical Priority**: ❌ **NO HARDWARE-FREE VALIDATION AVAILABLE**

**Platform Migration Impact**:
- **January 2024**: NIBE completed migration from legacy "NIBE Uplink" to "myUplink" platform [1]
- **Demo Environment**: Previous demo accounts eliminated during platform transition [2]
- **Current Status**: API validation limited to documentation review and community library analysis only
- **Control Testing**: Requires actual NIBE S-series heat pump for validation

**Available Validation Options**:
- ✅ **API Documentation**: Complete Swagger specification available at api.myuplink.com [3]
- ✅ **Community Libraries**: Active Python libraries with real-world usage evidence [4]
- ✅ **Home Assistant Integration**: 1037+ active installations provide community validation [5]
- ❌ **Demo Environment**: Not available - eliminated during platform migration

**Impact on Priority**: Hardware requirement reduces Phase 1 viability but strong community validation and comprehensive documentation maintain high strategic value for Phase 1B implementation.

### Business Model Alignment
**NordicFlux Strategy Compatibility**:
- ✅ **Dual API Model**: Consumer API for B2C + PRO API for B2B installer partnerships [6]
- ✅ **Zero Operational Costs**: Free API access with reasonable rate limits (25 requests/minute) [7]
- ✅ **Target Market Fit**: NIBE S-series users seeking smart optimization without hardware replacement
- ✅ **Scalability Path**: OAuth 2.0 individual authentication scales to multi-user deployment

---

## Technical Capabilities Assessment

### Heat Pump Control
**Available Endpoints** [3]:
- **`GET /v2/devices/{deviceId}/points`**: Retrieve all device data points and current values
- **`PATCH /v2/devices/{deviceId}/points`**: Modify device settings and control parameters
- **`PATCH /v2/devices/{deviceId}/zones/{zoneId}`**: Update zone-specific heating settings
- **`GET /v2/systems/{systemId}/smart-home-mode`**: Get current smart home automation mode
- **`PUT /v2/systems/{systemId}/smart-home-mode`**: Set smart home mode for system-wide control

**Key Control Capabilities**:
- ✅ **Temperature Control**: "Change settings on device" via PATCH endpoints [3]
- ✅ **Zone Management**: Individual zone temperature and scheduling control [3]
- ✅ **Smart Home Integration**: System-wide automation mode control [3]
- ✅ **Real-time Monitoring**: Live data points for optimization feedback [3]
- ❓ **Direct Heat Pump Commands**: Specific heating/cooling commands require hardware validation

### Authentication & Access
**OAuth 2.0 Implementation** [8]:
- **Requirements**: Client ID and Client Secret from dev.myuplink.com application registration
- **Scopes/Permissions**: Standard OAuth scopes for device access and control
- **Business Model Compatibility**: Both individual B2C users and B2B installer accounts supported

**Dual API Architecture**:
- **Consumer API**: Individual homeowner OAuth authentication for B2C model [6]
- **PRO API**: Installer/technician accounts for B2B multi-customer management [6]

### Rate Limits & Reliability
- **Rate Limits**: "60 seconds" polling interval recommended by Home Assistant integration [5]
- **Reliability**: 1037+ active Home Assistant installations demonstrate production stability [5]
- **Costs**: Free API access with no documented usage fees [7]

---

## Reference Implementation Analysis

### Primary Library: `pajzo/myuplink` [GitHub - Home Assistant Core]
**Repository**: https://github.com/pajzo/myuplink  
**Status**: Active maintenance as part of Home Assistant core integration (2024.2+)

**Key Features**:
- ✅ **OAuth 2.0 Support**: "Client ID and Client Secret created above" authentication flow [8]
- ✅ **Async Implementation**: Compatible with FastAPI async patterns
- ✅ **Production Usage**: "1037 active installations" in Home Assistant [5]
- ✅ **Device Discovery**: Automatic system and device enumeration
- ✅ **Real-time Data**: Live sensor readings and status monitoring

**Implementation Example** [5]:
```python
# Home Assistant myUplink integration pattern
# Source: https://www.home-assistant.io/integrations/myuplink/ (Accessed: 2026-01-12)

# OAuth 2.0 Authentication Flow
# 1. Register application at dev.myuplink.com
# 2. Configure Client ID and Client Secret
# 3. Use OAuth redirect for user authorization
# 4. Poll API every 60 seconds for data updates
```

### Alternative Library: `elupus/nibeuplink` [DEPRECATED]
**Repository**: https://github.com/elupus/nibeuplink  
**Status**: ❌ **ARCHIVED December 3, 2024** - "Nibe is shutting down nibeuplink.com" [9]

**Migration Notice** [9]:
- **Legacy Platform**: Original NIBE Uplink service discontinued
- **Replacement**: "Upgrade your heatpump and switch to myuplink solution" [9]
- **Impact**: All legacy integrations must migrate to myUplink API

---

## Implementation Recommendations

### Phase 1B: Hardware-Required Validation
**Immediate Implementation** [based on research findings]:
1. **OAuth Application Setup**: Register at dev.myuplink.com with callback URL configuration [8]
2. **Library Integration**: Use Home Assistant's `pajzo/myuplink` library patterns for proven implementation
3. **Hardware Acquisition**: Secure access to NIBE S-series heat pump for control validation
4. **API Testing**: Validate control endpoints using actual hardware before production deployment

**Adapter Interface** [following NordicFlux patterns]:
```python
# Implementation pattern based on Home Assistant integration [5]
class NibeMyUplinkAdapter(EnergyDevice):
    async def get_status(self) -> Status:
        # Use /v2/devices/{deviceId}/points for current state
        # Source: myUplink Swagger API documentation [3]
    
    async def set_heating_control(self, zone_id: str, temperature: float):
        # Use PATCH /v2/devices/{deviceId}/zones/{zoneId}
        # Source: myUplink API endpoint specification [3]
    
    async def set_smart_home_mode(self, mode: str):
        # Use PUT /v2/systems/{systemId}/smart-home-mode
        # Source: myUplink system control API [3]
```

---

## Critical Research Questions

### 1. Hardware Validation Requirements
**Question**: What specific NIBE S-series models provide optimal control capabilities for NordicFlux optimization?  
**Investigation**: Contact NIBE partners or community members with S-series installations for validation access  
**Impact**: Determines Phase 1B implementation timeline and hardware acquisition strategy  
**Sources**: NIBE official compatibility documentation [10], Home Assistant community feedback

### 2. Control Granularity Assessment
**Question**: What level of heating control granularity is available through myUplink API endpoints?  
**Investigation**: Test PATCH endpoints with actual hardware to determine MPC integration capabilities  
**Impact**: Defines optimization algorithm precision and energy savings potential  
**Sources**: myUplink API Swagger documentation [3], community implementation examples

### 3. Business Model Validation
**Question**: How do consumer vs PRO API access models affect NordicFlux's B2C/B2B strategy?  
**Investigation**: Research PRO API pricing and installer partnership requirements  
**Impact**: Determines revenue model scalability and installer partnership viability  
**Sources**: myUplink PRO terms of service [6], installer program documentation

---

## Sources & References

**Official Documentation**:
- [1] NIBE Official myUplink Compatibility - https://www.nibe.eu/en-eu/products/smart-home-accessories/faq-smart-home-accessories/which-heat-pumps-can-be-connected-to-myuplink (Accessed: 2026-01-12)
- [2] myUplink Developer Portal - https://dev.myuplink.com/ (Accessed: 2026-01-12)
- [3] myUplink API Swagger Documentation - https://api.myuplink.com/swagger/index.html (Accessed: 2026-01-12)
- [6] myUplink Terms of Service - https://dev.myuplink.com/terms-of-service (Accessed: 2026-01-12)
- [7] myUplink API Services Agreement - https://dev.myuplink.com/api-services-agreement (Accessed: 2026-01-12)

**Implementation Libraries**:
- [4] pajzo/myuplink - GitHub repository (Home Assistant core integration)
- [9] elupus/nibeuplink - https://github.com/elupus/nibeuplink (ARCHIVED: December 3, 2024)

**Community Resources**:
- [5] Home Assistant myUplink Integration - https://www.home-assistant.io/integrations/myuplink/ (Accessed: 2026-01-12)
- [8] Home Assistant myUplink Setup Guide - https://www.home-assistant.io/integrations/myuplink/ (Accessed: 2026-01-12)
- [10] NIBE S-series Compatibility FAQ - https://www.nibe.eu/en-eu/products/smart-home-accessories/faq-smart-home-accessories/which-heat-pumps-can-be-connected-to-myuplink (Accessed: 2026-01-12)

---

*Research completed: January 12, 2026*  
*Next update: After hardware validation access secured*  
*Citation format: All claims verified against primary sources listed above*

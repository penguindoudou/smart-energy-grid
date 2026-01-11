# NIBE myUplink API Integration Research - Documentation Correction

## Executive Summary
**Verdict**: ❓ **MEDIUM PRIORITY - PHASE 2** (Hardware dependency barrier)  
NIBE myUplink API offers excellent technical capabilities and mature community support, but **requires physical hardware for any API validation**. The free B2C API eliminates subscription concerns, but hardware dependency makes it unsuitable for Phase 1 validation without hardware access or community partnerships.

**Strategic Use Cases**:
- **Phase 2**: S-series heat pump optimization via free B2C API after hardware access secured
- **Phase 3**: B2B PRO API for installer partnerships managing multiple customer systems
- **Revenue Model**: B2C individual subscriptions (free API), B2B installer partnerships (PRO API costs TBD)

---

## Validation Strategy - CORRECTED

### Hardware-Free Testing Assessment
**❌ NO HARDWARE-FREE VALIDATION AVAILABLE**

**Critical Findings from Official Documentation**:
- **B2C API**: "You can only get data from your own equipment. Please ensure that the account used has active devices" [1]
- **B2B PRO API**: "You can only get data from the devices you have access to. Please ensure that the account used has active devices" [2]
- **No Demo Environment**: Unlike Victron VRM Portal, NIBE provides no sandbox or demo accounts

**Impact on Priority**: Hardware requirement **downgrades priority to PHASE 2** - unsuitable for immediate validation without:
- Hardware investment (expensive NIBE S-series purchase)
- Community partnership (Home Assistant users with NIBE systems)
- Installer partnership (Swedish NIBE dealers for test access)

### Business Model Alignment - UPDATED
**NordicFlux Strategy Compatibility**:
- **✅ Zero operational costs**: B2C API is completely free, no subscription fees [1]
- **✅ Multi-tier revenue strategy**: B2C free API + B2B PRO API (subscription cost TBD) [1][2]
- **✅ Target market fit**: Large Swedish installed base, strong Home Assistant adoption
- **❌ Phase 1 validation barrier**: Cannot validate without hardware access

---

## Technical Capabilities Assessment - CONFIRMED

### API Architecture - DUAL SYSTEM
**B2C Consumer API** (`api.myuplink.com`) [1]:
- **Target**: Individual homeowners connecting their own devices
- **Cost**: **FREE** - "A free myUplink account" required
- **Rate Limit**: 25 requests per minute
- **Authentication**: OAuth 2.0, users connect own accounts

**B2B Professional API** (`api-pro.myuplink.com`) [2]:
- **Target**: Service partners managing multiple customer devices  
- **Cost**: "myUplink PRO account with premium subscription" (cost unknown)
- **Rate Limit**: 25 requests per minute
- **Authentication**: OAuth 2.0, service partner accounts

### Heating Control Capabilities - CONFIRMED
**Available Endpoints** [1][2]:
- **System Management**: GET /v2/systems/me, GET /v2/systems/{systemId}
- **Device Control**: GET /v2/devices/{deviceId}, device points endpoints
- **Parameter Control**: GET/PUT /v2/devices/{deviceId}/points for temperature control

**Key Control Capabilities**:
- ✅ **Temperature Control**: Device points endpoints support parameter modification
- ✅ **System Monitoring**: Real-time system status and telemetry data
- ✅ **Multi-Device Support**: Both APIs support multiple devices per account
- ✅ **No Subscription Validation**: B2C API is free, eliminates subscription complexity

### Rate Limits & Reliability - DOCUMENTED
- **Rate Limits**: 25 requests per minute for both APIs [1][2]
- **Reliability**: Production APIs with established HTTP conventions and error handling
- **Costs**: B2C free, B2B PRO subscription cost requires investigation

---

## Implementation Recommendations - REVISED

### Phase 1: DEFERRED (Hardware Dependency)
**Barrier**: Cannot validate API without physical NIBE hardware access
**Alternative**: Focus on Victron VRM Portal (demo environment available)

### Phase 2: Hardware Access Strategy
**Implementation Options**:
1. **Community Partnership**: Partner with Home Assistant NIBE users for testing
2. **Installer Partnership**: Contact Swedish NIBE dealers for development access
3. **Hardware Investment**: Purchase NIBE S-series for dedicated development
4. **Customer-Driven**: Wait for paying customers with existing NIBE systems

**Adapter Interface** [following NordicFlux patterns]:
```python
# Implementation pattern based on official API documentation [1][2]
class NibeMyUplinkAdapter(EnergyDevice):
    def __init__(self, api_type="consumer"):  # "consumer" or "pro"
        self.base_url = "api.myuplink.com" if api_type == "consumer" else "api-pro.myuplink.com"
        self.rate_limit = 25  # requests per minute
        
    async def get_status(self) -> Status:
        # GET /v2/systems/me -> GET /v2/devices/{deviceId}/points
        # Free API, no subscription validation needed
        
    async def set_heating_temperature(self, temperature: float):
        # PUT /v2/devices/{deviceId}/points
        # Control via device points endpoints
```

---

## Critical Research Questions - UPDATED

### 1. Hardware Access Strategy
**Question**: How to gain NIBE hardware access for API validation?  
**Investigation**: Contact Home Assistant community, Swedish installers, or hardware investment  
**Impact**: Determines Phase 2 implementation timeline and development costs  
**Priority**: **CRITICAL** - blocks all API validation

### 2. B2B PRO API Subscription Costs
**Question**: What does myUplink PRO premium subscription cost?  
**Investigation**: Contact NIBE sales or existing service partners  
**Impact**: Determines B2B revenue model viability and installer partnership pricing  
**Sources**: NIBE commercial documentation, installer partnerships

### 3. Device Points Control Capabilities
**Question**: Which specific heating parameters can be controlled via device points?  
**Investigation**: Test with actual hardware - temperature curves, schedules, modes  
**Impact**: Determines optimization scope and MPC integration possibilities  
**Sources**: API testing with real NIBE systems

---

## Sources & References
**Official Documentation**:
- [1] myUplink B2C API Documentation - https://dev.myuplink.com/documentation/intro?activeTab=intro (Login required, accessed: 2026-01-11)
- [2] myUplink B2B PRO API Documentation - https://dev.myuplink.com/pro-documentation/intro?activeTab=intro (Login required, accessed: 2026-01-11)
- [3] Home Assistant myUplink Integration - https://www.home-assistant.io/integrations/myuplink/ (Accessed: 2026-01-11)

**Implementation Libraries**:
- [4] myuplink Python Package - https://pypi.org/project/myuplink/0.6.0rc1/ (Version: 0.6.0rc1, Last updated: March 2024)
- [5] Deprecated nibeuplink Library - https://github.com/elupus/nibeuplink (Deprecated: December 2024)

**Community Resources**:
- [6] Home Assistant Community Discussions - Multiple forum threads confirming hardware requirements
- [7] OpenHAB NIBE Integration - Community validation of API capabilities

---

*Research completed: 2026-01-11*  
*Correction: Hardware dependency identified, priority downgraded to Phase 2*  
*Next update: When hardware access strategy is determined*

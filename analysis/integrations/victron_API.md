# Victron VRM Portal API Integration Research

## Executive Summary
**Verdict**: ✅ **HIGH PRIORITY - PHASE 2**  
Strong Phase 2 candidate with comprehensive monitoring capabilities and proven ESS control functionality. Well-established API with active community usage, though control capabilities require further investigation for MPC integration.

**Strategic Use Cases**:
- **Phase 2**: Primary ESS battery optimization target with proven control capabilities
- **Market Expansion**: Large Victron user base across Europe and global markets
- **Revenue Model**: B2C compatible with individual user authentication

---

## Technical Capabilities Assessment

### Battery & ESS Control
**Available Control Endpoints**:
- **ESS State Control**: `/Settings/CGwacs/BatteryLife/State` - Controls battery charging modes
- **Minimum SOC Control**: `/Settings/CGwacs/BatteryLife/MinimumSocLimit` - Sets discharge limits
- **Grid Setpoint Control**: Available for feed-in/consumption control
- **Switch Position Control**: `/Mode` - Controls inverter/charger operation modes

**Key Control Capabilities**:
- ✅ **ESS Mode Control**: "Keep batteries charged" (State 9) vs "Optimized" (State 10/11)
- ✅ **SOC Limits**: Dynamic minimum discharge SOC setting for charge/discharge control
- ✅ **Real-time Control**: Node-RED community demonstrates live ESS control
- ✅ **Grid Management**: Feed-in control and consumption optimization
- ❓ **Direct Charge/Discharge**: Requires investigation of power setpoint control

### Authentication & Access
**Token-Based Authentication**:
- **Primary Method**: Username/password → Bearer token workflow
- **API Access Tokens**: Available via VRM Portal (Preferences → Integrations → Access tokens)
- **Security Challenge**: "API access tokens still require initial auth/login for idUser discovery"
- **Business Model Compatibility**: B2C individual user authentication supported

### Rate Limits & Reliability
- **Rate Limits**: "Most endpoints are by default rate limited with a rolling window of max 200 requests, where every 0.33 seconds a request gets removed from the rolling window"
- **Practical Limit**: ~200 requests per 66 seconds (3 requests/second sustained)
- **Reliability**: Mature infrastructure with established community usage
- **Costs**: Free API access, no documented pricing restrictions

---

## Reference Implementation Analysis

### Primary Library: `ocf-vrmapi`
**Repository**: https://pypi.org/project/ocf-vrmapi/  
**Status**: Actively maintained by Open Climate Fix (OCF), version 0.1.4 (Oct 2024)

**Key Features**:
- ✅ **Modern Maintenance**: "This repo is being maintained by OCF because the original was not being maintained by Victron"
- ✅ **Authentication**: Token-based authentication support
- ✅ **Data Retrieval**: Comprehensive monitoring data access
- ❓ **Control Commands**: Control capability documentation needs investigation

**Implementation Example**:
```python
# Based on community Node-RED patterns and API documentation
import requests

# Authentication
login_url = 'https://vrmapi.victronenergy.com/v2/auth/login'
login_data = {'username': 'user@example.com', 'password': 'password'}
response = requests.post(login_url, json=login_data)
token = response.json()['token']
user_id = response.json()['idUser']

# Headers for subsequent requests
headers = {'X-Authorization': f'Bearer {token}'}

# Get installations
installations_url = f'https://vrmapi.victronenergy.com/v2/users/{user_id}/installations'
installations = requests.get(installations_url, headers=headers).json()
site_id = installations['records'][0]['idSite']

# Monitor battery SOC
stats_url = f'https://vrmapi.victronenergy.com/v2/installations/{site_id}/stats/latest'
battery_data = requests.get(stats_url, headers=headers).json()

# Control ESS State (based on Node-RED community examples)
# State 9 = "Keep batteries charged", State 10 = "Optimized mode"
control_url = f'https://vrmapi.victronenergy.com/v2/installations/{site_id}/settings'
control_data = {
    'path': '/Settings/CGwacs/BatteryLife/State',
    'value': 9  # Keep batteries charged
}
requests.post(control_url, json=control_data, headers=headers)
```

### Secondary Reference: `victronenergy/vrm-api-python-client`
**Repository**: https://github.com/victronenergy/vrm-api-python-client  
**Status**: ⚠️ "NOT ACTIVELY MAINTAINED" - Reference only

**Key Features**:
- ✅ **Official Origin**: Originally from Victron Energy
- ✅ **Proven Patterns**: Established authentication and data retrieval patterns
- ❌ **Maintenance**: No longer actively maintained by Victron

---

## Implementation Recommendations

### Phase 2: ESS Control Integration
**Immediate Implementation**:
1. **Use `ocf-vrmapi` library**: Actively maintained alternative to official client
2. **Implement ESS State Control**: Leverage proven Node-RED community patterns
3. **SOC Limit Management**: Use MinimumSocLimit for charge/discharge control
4. **Rate Limit Compliance**: Implement 3 requests/second maximum with queuing

**Adapter Interface**:
```python
class VictronAdapter(EnergyDevice):
    async def get_status(self) -> Status:
        # Get battery SOC, power, and ESS state
        stats = await self.api.get_installation_stats(self.site_id)
        return Status(
            soc=stats['battery_soc'],
            power=stats['battery_power'],
            mode=stats['ess_state']
        )
    
    async def set_charge_mode(self, enabled: bool):
        # ESS State: 9 = Keep charged, 10 = Optimized
        state = 9 if enabled else 10
        await self.api.set_ess_state(self.site_id, state)
    
    async def set_soc_limit(self, min_soc: float):
        # Set minimum discharge SOC for battery protection
        await self.api.set_min_soc_limit(self.site_id, min_soc)
```

---

## Critical Research Questions

### 1. Direct Power Control Capabilities
**Question**: Can VRM API control specific charge/discharge power levels, or only ESS modes?  
**Investigation**: Test control endpoints beyond ESS state - look for power setpoint controls  
**Impact**: Determines if fine-grained MPC control is possible vs binary charge/hold modes

### 2. Control Latency and Data Freshness
**Question**: What is the latency between API control commands and actual device response?  
**Investigation**: Measure time from API call to device state change in real installation  
**Impact**: Critical for MPC optimization timing and constraint satisfaction

### 3. Multi-Device Installation Support
**Question**: How does the API handle installations with multiple batteries or inverters?  
**Investigation**: Test API responses for complex installations with multiple devices  
**Impact**: Affects scalability to larger residential and commercial installations

---

## Sources & References

**Official Documentation**:
- [Victron VRM API Overview](https://docs.victronenergy.com/vrmapi/overview.html)
- [VRM API Documentation](https://vrm-api-docs.victronenergy.com/#/)

**Implementation Libraries**:
- [ocf-vrmapi (PyPI)](https://pypi.org/project/ocf-vrmapi/) - Actively maintained
- [victronenergy/vrm-api-python-client](https://github.com/victronenergy/vrm-api-python-client) - Reference only

**Community Examples**:
- [Node-RED Tibber ESS Control Flow](https://flows.nodered.org/flow/6822fd63b61538059faa9b93d3a63d28) - Proven ESS control patterns
- [Victron Community ESS Control Discussion](https://community.victronenergy.com/t/node-red-changing-ess-mode/45748)

**Rate Limiting Information**:
- [VRM API Rate Limits Discussion](https://community.victronenergy.com/t/too-many-requests-please-try-again-in-a-few-minutes-1512/25995) - "200 requests rolling window, 0.33 seconds per request removal"

---

*Research completed: January 10, 2026*  
*Next update: After Phase 1 Tesla validation - investigate direct power control capabilities*

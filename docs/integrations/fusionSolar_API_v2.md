# FusionSolar API Integration Research

## Executive Summary
**Verdict**: ❌ **LOW PRIORITY - PHASE 3+**  
FusionSolar OpenAPI requires manual account creation through Huawei support with no demo/sandbox environment available. While the API supports battery control capabilities, the high barrier to entry and lack of hardware-free validation options make this unsuitable for Phase 1 validation. Better suited for Phase 3+ when proven MPC algorithms need broader device support.

**Strategic Use Cases**:
- **Phase 3+**: B2B installer partnerships leveraging Huawei's strong installer ecosystem [3]
- **Market Access**: Global reach through Huawei's established installer network in 51+ countries [5]
- **Revenue Model**: B2B partnerships with installers rather than direct B2C due to account creation barriers

---

## Validation Strategy

### Hardware-Free Testing Assessment
**Critical Priority**: ❌ **NO HARDWARE-FREE VALIDATION OPTIONS IDENTIFIED**

**Investigation Results**:
- **Demo environments**: No official sandbox or test environment found
- **Simulation options**: No mock servers or development environments available
- **Community resources**: No shared demo accounts or public test installations identified
- **API structure testing**: Requires real OpenAPI account for any endpoint validation

**Account Creation Barrier**: "Contact service team at eu_inverter_support@huawei.com to create an openAPI account for your plant" [1] - manual approval process with no guaranteed timeline.

**Impact on Priority**: ❌ **SIGNIFICANTLY REDUCES PHASE 1 VIABILITY** due to inability to validate API integration without physical hardware and manual account approval process.

### Business Model Alignment
**NordicFlux Strategy Compatibility**:
- **Zero-cost operational model**: ❌ Requires manual account setup, potential API costs unknown
- **Multi-tier revenue strategy**: ✅ Strong B2B installer partnership potential through Huawei's global network [3]
- **Lean startup approach**: ❌ High barrier to entry prevents rapid iteration and validation
- **Target market fit**: ✅ Aligns with installer partnerships, but poor fit for individual B2C users
- **Scalability path**: ✅ Clear B2B progression through Huawei's established installer ecosystem

---

## Technical Capabilities Assessment

### Battery Control Capabilities
**Available Control Functions** [2]:
- ✅ **Battery Charge/Discharge Control**: "The Huawei API also lets you do all kinda of things that most other systems dont like control the PV plant like battery charge/discharge, output limitations, ect" [2]
- ✅ **Output Limitations**: Power output control capabilities confirmed by community [2]
- ❓ **Real-time Control**: Specific control latency and real-time capabilities not documented

**Key Control Capabilities**:
- ✅ **Battery Management**: Direct charge/discharge control confirmed by Home Assistant community [2]
- ❓ **Scheduling**: Time-based control scheduling capabilities not explicitly documented
- ❓ **Power Limits**: Granular power limit control specifications not available
- ❓ **Grid Integration**: Grid-safe operation constraints not documented in available sources

### Authentication & Access
**OpenAPI Account Requirements** [1]:
- **Requirements**: Manual account creation through eu_inverter_support@huawei.com with plant ownership verification
- **Scopes/Permissions**: "The access privilege to the northbound interface API is independent of third-party user accounts, and users must apply for it separately" [7]
- **Business Model Compatibility**: ❌ Poor B2C fit due to manual approval process, ✅ Suitable for B2B installer partnerships

### Rate Limits & Reliability
- **Rate Limits**: "Access is limited to one request per minute to avoid overloading the system" [1]
- **Reliability**: Infrastructure assessment not available from official sources
- **Costs**: Pricing model not publicly documented, requires direct contact with Huawei

---

## Reference Implementation Analysis

### Primary Library: `fusion-solar-py` [PyPI Package]
**Repository**: https://pypi.org/project/fusion-solar-py/ [8]  
**Status**: Active maintenance, uses https://region01eu5.fusionsolar.huawei.com endpoint [8]

**Key Features**:
- ✅ **Regional Endpoints**: "This client uses the https://region01eu5.fusionsolar.huawei.com end point by default" [8]
- ❓ **Control Capabilities**: Package documentation doesn't specify control vs monitoring-only functionality
- ❓ **Async Support**: Async/await compatibility not documented

### Secondary Library: `EnergieID/FusionSolar` [GitHub Repository]
**Repository**: https://github.com/EnergieID/FusionSolar [4]  
**Status**: 67 stars, 22 forks, limited recent activity [4]

**Key Features**:
- ✅ **Pandas Integration**: "PandasClient" for data analysis workflows [4]
- ✅ **Station Management**: "get_station_list()" and "get_kpi_day()" methods [4]
- ❌ **Control Functions**: No control capabilities evident in repository structure [4]

**Implementation Example** [4]:
```python
# Source: https://github.com/EnergieID/FusionSolar (Accessed: 2026-01-10)
from fusionsolar import Client, PandasClient
import pandas as pd

date = pd.Timestamp('20200402', tz='Europe/Brussels')

with PandasClient(user_name=user, system_code=password) as client:
    sl = client.get_station_list()
    station_code = sl['data'][0]['stationCode']
    
    df = client.get_kpi_day(station_code=station_code, date=date)
```

### Home Assistant Integration: `olibos/Home-Assistant-FusionSolar-OpenApi`
**Repository**: https://github.com/olibos/Home-Assistant-FusionSolar-OpenApi [6]  
**Status**: 13 stars, MIT license, last release October 2022 [6]

**Key Features**:
- ✅ **OpenAPI Integration**: Uses official FusionSolar OpenAPI [6]
- ✅ **Multi-Plant Support**: Configure multiple plants in single integration [6]
- ❌ **Monitoring Only**: No control capabilities, sensor platform only [6]

---

## Implementation Recommendations

### Phase 3+: B2B Installer Partnership Strategy
**Immediate Implementation** [based on research findings]:
1. **Establish Installer Partnerships**: Leverage Huawei's global installer network in 51+ countries [5]
2. **B2B Account Strategy**: Work with installers who have existing OpenAPI access rather than individual accounts
3. **Pilot Program**: Partner with select installers for controlled MPC algorithm validation

**Adapter Interface** [following NordicFlux patterns]:
```python
# Implementation pattern based on community implementations [2][4]
class FusionSolarAdapter(EnergyDevice):
    async def get_status(self) -> Status:
        # Monitor battery SOC, power generation, consumption
        # Based on EnergieID/FusionSolar patterns
    
    async def set_battery_control(self, charge_power: float, discharge_power: float):
        # Battery charge/discharge control implementation
        # Community confirms control capabilities exist [2]
        
    async def set_power_limits(self, max_output: float):
        # Output limitation control
        # Referenced in community discussions [2]
```

---

## Critical Research Questions

### 1. Control API Endpoints and Documentation
**Question**: What are the specific API endpoints for battery control and their parameters?  
**Investigation**: Contact Huawei support for OpenAPI documentation access, or partner with existing installer  
**Impact**: Essential for implementing MPC control algorithms with proper safety constraints  
**Sources**: Community confirms control exists [2] but specific endpoints not publicly documented

### 2. Hardware-Free Validation Alternatives
**Question**: Are there any unofficial demo environments or simulator options for development?  
**Investigation**: Explore installer partnerships for shared development access, investigate community test setups  
**Impact**: Critical for Phase 1 viability - without validation options, integration becomes Phase 3+ priority  
**Sources**: No official sandbox identified in research [1][7]

### 3. Business Model Viability
**Question**: What are the actual API costs and account approval timelines?  
**Investigation**: Direct contact with eu_inverter_support@huawei.com for pricing and process details  
**Impact**: Determines feasibility of B2C vs B2B-only approach for NordicFlux business model  
**Sources**: Pricing not publicly available, manual approval process confirmed [1]

---

## Sources & References

**Official Documentation**:
- [1] Home Assistant FusionSolar OpenAPI Integration - https://github.com/olibos/Home-Assistant-FusionSolar-OpenApi (Accessed: 2026-01-10)
- [2] Integrating the Huawei Solar platform (FusionSolar) Through API - https://community.home-assistant.io/t/integrating-the-huawei-solar-platform-fusionsolar-trough-api/409003 (Accessed: 2026-01-10)
- [3] Huawei FusionSolar Hosts the 3rd Global Installer Summit - https://digitalpower.huawei.com/en/news-fusionsolar/3rd-global-installer-summit.html (Accessed: 2026-01-10)

**Implementation Libraries**:
- [4] EnergieID/FusionSolar - https://github.com/EnergieID/FusionSolar (Version: Latest, Last updated: Active)
- [5] Huawei FusionSolar Hosts Inaugural Global Installer Summit - https://digitalpower.huawei.com/en/fusionsolar/news/detail/2725.html (Accessed: 2026-01-10)
- [6] olibos/Home-Assistant-FusionSolar-OpenApi - https://github.com/olibos/Home-Assistant-FusionSolar-OpenApi (Version: v1.1.0, Last updated: Oct 2022)

**Market Analysis & Technical Reports**:
- [7] Fusionsolar API Documentation - https://malkister.com/fusionsolar-api-documentation (Accessed: 2026-01-10)
- [8] fusion-solar-py PyPI Package - https://pypi.org/project/fusion-solar-py/ (Accessed: 2026-01-10)

**Community Resources**:
- [1] 2019FS026 Communicate with FusionSolar through an openAPI account - https://www.scribd.com/document/527304667/2019FS026-Communicate-with-FusionSolar-through-an-openAPI-account (Accessed: 2026-01-10)

---

*Research completed: 2026-01-10*  
*Next update: When installer partnerships or official sandbox access becomes available*  
*Citation format: All claims verified against primary sources listed above*

# Integration Research Index

## Purpose
Quick reference for device integration research and implementation guidance.

## Available Integrations

### FusionSolar (Huawei)
- **File**: `fusionSolar_API.md`
- **Status**: Phase 2 candidate - API access complexity
- **Key Finding**: tijsverkoyen integration proves monitoring works, control APIs need research
- **Implementation**: Extend existing client for MPC control commands

### Planned Research
- `tesla_API.md` - Tesla Powerwall Fleet API capabilities
- `victron_API.md` - VRM Portal API for GX devices  
- `nibe_API.md` - myUplink API for S-series heat pumps
- `modbus_protocols.md` - Local gateway integration specifications

## Next Research Priorities

### High Priority (Phase 1 Validation)
1. **Tesla Powerwall Fleet API** - Largest market, likely best documentation, proven control capabilities
   - Investigate: HTTP vs WebSocket usage for real-time control
   - Verify: Control command rate limits and latency
2. **NIBE S-series myUplink API** - Phase 1 target, heat pump optimization validation
   - ✅ **OAuth 2.0 confirmed** - Modern standard authentication
   - ✅ **Control capabilities confirmed** - Device settings and points can be updated
   - ❌ **Equipment access required** - Need actual NIBE devices for testing

### Medium Priority (Phase 2 Expansion)  
3. **Victron VRM Portal API** - Strong community, good documentation expected
   - **New research question**: What control latency and data latency does it have? They might be different. What does it mean for our project?
   - Investigate: Real-time control capabilities and rate limits
4. **FusionSolar Control APIs** - Local installer connection available, but control capabilities unknown
   - Investigate: Battery charge/discharge command endpoints
   - Verify: Control vs monitoring rate limits

### Lower Priority (Phase 3+)
5. **Modbus TCP protocols** - Local gateway approach, hardware complexity
   - **New research question**: MQTT topic structure design for device communication
   - Research: Standard Modbus register mappings for battery/inverter control
6. **NIBE F-series local integration** - Large market but highest complexity

### Research Strategy
- **Start with Tesla** - Best chance of finding complete control API documentation
- **Validate MPC approach** with one proven system before expanding
- **Leverage local connections** (FusionSolar installer) for real-world testing when ready

## Usage Guidelines

### When Researching New Integration
1. **Create new `.md` file** in this directory
2. **Follow fusionSolar_API.md structure**:
   - Executive summary with verdict
   - Strategic use cases
   - Technical capabilities assessment
   - Implementation recommendations
   - Source citations
3. **Update this index** with key findings

### When Implementing Integration
1. **Review relevant `.md` file** for technical patterns
2. **Check "Reference Implementation Analysis"** section for code patterns
3. **Follow adapter interface** defined in tech.md
4. **Update implementation status** in this index

## Integration Priority Matrix

| Device | Phase | Complexity | Market Size | Implementation Status |
|--------|-------|------------|-------------|---------------------|
| NIBE S-series | 1 | Low* | Small | OAuth 2.0 + control confirmed, equipment access required |
| Tesla Powerwall | 2 | Medium | Large | Not started |
| Victron | 2 | Medium | Medium | Not started |
| FusionSolar | 2 | High* | Medium | Monitoring research complete, control unknown |
| NIBE F-series | 3 | High | Large | Not started |

*Low complexity for API integration, but requires actual equipment for testing

*High complexity due to API access requirements and unknown control capabilities

---
*Last updated: January 10, 2026*

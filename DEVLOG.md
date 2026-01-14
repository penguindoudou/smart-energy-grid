# Development Log - NordicFlux

**Project**: NordicFlux - Zero-Cost SaaS Energy Management System  
**Duration**: January 5-23, 2026  
**Total Time**: 14 hours  

## Overview
Building a zero-cost SaaS Energy Management System using Model Predictive Control (MPC) to optimize battery storage and thermal heating based on free Nordpool prices and weather data. The system targets Swedish homeowners with heat pumps and battery systems, focusing on immediate value delivery with continuous learning.

### Day 6 (Jan 11-12) - Workflow Development & Technical Research [8h]


  - **Key Accomplishments**:
    - Integrated s.jina, r.jina for as an inline tool for and managed to get a subagent to use it to conduct research - this makes me trust the agent more
    - Being able to prompt the agent to test itself and run several iteration on the same prompt and see different results gives me higher confidence when the results are aligned
    - Asked kiro to evaluate it's own research regarding an NIBE Uplink API, which led to a better research prompt 
    - Researched Fusion Solar API and NIBE S-series integration options
    - Enhanced project analysis prompts for better setup workflows

  **Challenges**:
  - **Research Rabbit vs Smart House vs Learning the Kiro Tool**: Research is interesting and so is improving the system, but gotta start coding soon. We improved the research process slightly, I'm wondering how far we could improve it here. Since a reliable research system that reasons over SOTA research and implements based on it would be awesome.

### Day 6 (Jan 10-11) - Workflow Development & Technical Research [8h]
- **Evening (Jan 10) - Morning (Jan 11)**: Research flow, research tracking and research evaluation refinement.

  - **Key Accomplishments**:
    - Managed to leave the details and focus on the overall picture
    - Specific prompts now tells the agent to use certain files in the file structure and save new ones 
    - Asked kiro to evaluate it's own research regarding an NIBE Uplink API, which led to a better research prompt 
    - Researched Fusion Solar API and NIBE S-series integration options
    - Enhanced project analysis prompts for better setup workflows

  **Challenges**:
  - **Research Rabbit Holes**: Research is interesting and so is improving the system, but gotta start coding soon. We improved the research process slightly, I'm wondering how far we could improve it here. Since a reliable research system that reasons over SOTA research and implements based on it would be awesome.
  - **How can I trust the LLM?**
  - Coding we can at least set up local tests, but information can be trickier. I do wonder if it would be different if I used RAG or a scarper. But isn't that similar to web fetch?
  - **Time Management**: 8 hours spent on research and prompt enhancement


### Day 5 (Jan 9-10) - Workflow Development & Technical Research [8h]
- **Evening (Jan 9) - Morning (Jan 10)**: Workflow creation and technical stack research (with food breaks)
- **Key Accomplishments**:
  - Created workflow to update tech stack systematically
  - Developed workflow to enhance product planning process
  - Conducted initial research on NIBE integration possibilities
  - Researched Fusion Solar API and NIBE S-series integration options
  - Enhanced project analysis prompts for better setup workflows

**Technical Research**:
- **NIBE Integration**: Investigated both S-series (myUplink API) and F-series (Modbus) approaches
- **Fusion Solar API**: Explored Huawei inverter integration possibilities
- **Workflow Automation**: Created systematic approaches for tech stack updates and product enhancement

**Critical Learning - LLM Usage Strategy**:
- **Problem**: Spending excessive time validating LLM-provided technical details
- **Insight**: LLMs should suggest frameworks/approaches, NOT provide implementation details
- **New Approach**: Use LLMs for suggestions → Get official documentation → Make decisions based on real docs
- **Impact**: This realization will significantly speed up technical decision-making process

**Challenges**:
- **Detail Rabbit Holes**: Getting lost in LLM-generated technical details instead of focusing on official sources
- **Time Management**: 8 hours spent on research/workflows vs actual implementation

**Solutions**:
- **Documentation-First Approach**: Prioritize official docs over LLM technical confirmations
- **Workflow Systematization**: Created repeatable processes for tech stack and product decisions
- **Research Boundaries**: Limit LLM usage to high-level suggestions, not detailed validation

**Kiro Usage**:
- **Workflow Creation**: Developed systematic prompts for tech stack updates
- **Project Analysis**: Enhanced setup workflows with complexity awareness
- **Research Organization**: Used Kiro to structure and document findings

**Git Activity**:
- Multiple commits on NIBE integration research
- Fusion Solar API investigation
- Workflow enhancement for product/tech updates
- Project analysis prompt improvements

---

## Week 1: Foundation & Strategic Planning (Jan 5-10)

### Day 3 (Jan 8) - Strategic Planning & Architecture Design [6h]
- **23:30-05:30**: Deep dive into Kiro CLI workflow and prompt ecosystem

### Day 4 (Jan 8-9) - Strategic Planning & Architecture Design [6h]
- **16:00-19:00 (Jan 8)**: Deep dive into Kiro CLI workflow and prompt ecosystem
- **23:30-03:46 (Jan 8-9)**: Collaborative product strategy refinement with AI assistants (Kiro + Gemini)
- **Key Accomplishments**: 
  - Completed comprehensive steering documents (product.md, tech.md, structure.md)
  - Defined zero-cost SaaS architecture with intelligent API selection
  - Established device integration priority strategy
  - Created development workflow with custom DEVLOG prompt

**Technical Decisions**:
- **API Selection**: Switched from ENTSO-E to Energi Data Service (Denmark) - no registration, clean JSON, government reliability, major reason: ENTSO-E API was not accessible 
- **Hosting Strategy**: Hetzner VPS for cost-effective European hosting with centralized optimization
- **Learning Approach**: Linear regression for thermal parameter calibration (physics-based, interpretable)
- **Battery Protection**: Integrated degradation cost modeling to prevent excessive cycling
- **Device Priority**: S-series NIBE (cloud) → Tesla/Victron (global) → Huawei (local) → F-series NIBE (Pi gateway)

**Market Strategy Insights**:
- **Primary Market**: NIBE F-series owners (70% of Swedish market, "dumb" pumps desperate for optimization)
- **Value Proposition**: "Make your dumb heat pump smart without a subscription" - avoid 100,000 SEK replacement
- **Revenue Model**: 30% of verified savings + hardware partnership revenue share

**Architecture Highlights**:
- **Zero-Cost Operation**: Free APIs only (Energi Data Service + Met.no weather)
- **Centralized MPC**: All optimization on VPS (x86 reliability), Pi as "dumb bridge"
- **Continuous Learning**: Start with conservative defaults, improve through real performance data
- **Grid-Safe Constraints**: No discharge to grid for regulatory compliance

**Challenges**:
- **Information Overload**: Managing extensive prompt ecosystem and AI-generated content
- **Workflow Learning Curve**: Understanding Kiro CLI capabilities feels slow initially but thorough
- **Technical Complexity**: Balancing advanced MPC optimization with user-friendly onboarding

**Solutions**:
- **Systematic Documentation**: Created comprehensive steering documents for future reference
- **Phased Implementation**: Clear device priority strategy to manage complexity
- **AI Collaboration**: Used multiple AI assistants (Kiro + Gemini) for cross-validation of technical decisions

**Kiro Usage**:
- **`@quickstart`**: Initial project setup and steering document configuration
- **`@prime`**: Load project context for comprehensive understanding
- **Custom prompt creation**: Developed `@update-devlog` for continuous progress tracking
- **Steering document refinement**: Multiple iterations on product strategy and technical architecture

**Key Learnings**:
- **Thorough planning pays off**: 6 hours of strategic planning creates solid foundation for implementation
- **AI collaboration effectiveness**: Using LLM together provides comprehensive technical validation if you intellectually engage with it 
- **Gemini Usage**: Using Gemini mainly for web-grounding, to save some kiro tokens, as well as another perspective
- **Market research importance**: Understanding F-series vs S-series NIBE market gave us insight of how the project could expand
- **Zero-cost constraint drives innovation**: Forced selection of better APIs and more efficient architecture

---

## Technical Decisions & Rationale

### API & Data Strategy
- **Energi Data Service over ENTSO-E**: No registration, clean JSON, government reliability
- **Met.no weather integration**: Global coverage, free, reliable forecasting
- **Redis caching strategy**: 24h price/weather data to respect API rate limits

### Optimization Architecture  
- **CVXPY for MPC**: Industry standard, reliable solver, handles constraints well
- **Linear regression for thermal learning**: Physics-based approach, interpretable results
- **Battery degradation modeling**: Prevents destructive cycling, protects user investment
- **Centralized computation**: VPS-based optimization for reliability and consistency

### Market & Business Strategy
- **Swedish market focus**: Leverage local knowledge and specific pain points
- **Device integration priority**: Start simple (cloud APIs), progress to complex (Pi gateways)
- **Revenue alignment**: Only profit when users save money (30% of verified savings)

---

## Time Breakdown by Category

| Category | Hours | Percentage |
|----------|-------|------------|
| Strategic Planning | 6h | 43% |
| Workflow Development | 4h | 29% |
| Technical Research | 3h | 21% |
| Documentation | 1h | 7% |
| **Total** | **14h** | **100%** |

---

## Kiro CLI Usage Statistics

- **Total Prompts Used**: 8
- **Most Used**: `@quickstart` (project setup), `@prime` (context loading)
- **Custom Prompts Created**: 1 (`@update-devlog`)
- **Steering Document Updates**: 15+ iterations
- **AI Collaboration**: Kiro + Gemini cross-validation approach

---

## Challenges & Solutions

### Challenge: Information Management Overload
- **Problem**: Extensive prompt ecosystem and AI-generated content difficult to process quickly
- **Solution**: Systematic documentation in steering documents, structured approach to planning
- **Learning**: Thorough planning phase essential for complex engineering projects

### Challenge: Workflow Learning Curve  
- **Problem**: Really wanted to understand the prompt workflow, but feels slow read it through initially
- **Solution**: Invested time in understanding full workflow, created custom prompts (update-devlog.md)
- **Learning**: Initial time investment in tooling pays dividends in implementation phase (I hope)

### Challenge: Technical Complexity Balance
- **Problem**: Advanced MPC optimization vs user-friendly experience
- **Solution**: Phased approach with smart defaults and continuous learning
- **Learning**: Start simple, add sophistication gradually based on real user data

---

## Next Steps & Priorities

### Immediate (Next Session)
1. **Plan first feature**: Use `@plan-feature` for MPC optimization engine
2. **Begin implementation**: Start with core CVXPY solver and thermal model
3. **Set up development environment**: Docker Compose with PostgreSQL, Redis

### Short Term (Week 1-2)
1. **Core optimization engine**: CVXPY-based MPC with RC thermal model
2. **Price data service**: Energi Data Service integration with caching
3. **Basic web interface**: Simulation endpoint and simple frontend

### Medium Term (Week 2-3)
1. **Device adapters**: Start with NIBE S-series (myUplink API)
2. **Thermal learning**: Implement linear regression parameter calibration
3. **Battery degradation**: Add cycle cost modeling to optimization

---

## Reflections

### What Went Well
- **Comprehensive planning**: 6 hours of strategic work created solid foundation
- **AI collaboration**: Kiro + Gemini combination provided excellent technical validation
- **Market insights**: Deep dive into NIBE market revealed true opportunity (F-series users)
- **Technical decisions**: Zero-cost constraint led to better architectural choices

### What Could Be Improved
- **Information processing speed**: Need strategies for faster validation of AI-generated content

### Key Insights
- **Planning investment**: Complex engineering projects benefit from thorough upfront planning
- **Market research impact**: Understanding user pain points completely changed product strategy
- **AI tool synergy**: Multiple AI assistants provide valuable cross-validation
- **Constraint-driven innovation**: Zero-cost requirement forced creative, better solutions

### Innovation Highlights
- **Continuous thermal learning**: Start with defaults, improve through real data
- **Battery degradation integration**: Protect user investment while optimizing
- **Grid-safe optimization**: Regulatory compliance through smart constraints
- **Device auto-detection**: Eliminate technical setup barriers for users

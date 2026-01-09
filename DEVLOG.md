# Development Log - NordicFlux

**Project**: NordicFlux - Zero-Cost SaaS Energy Management System  
**Duration**: January 5-23, 2026  
**Total Time**: 6 hours  

## Overview
Building a zero-cost SaaS Energy Management System using Model Predictive Control (MPC) to optimize battery storage and thermal heating based on free Nordpool prices and weather data. The system targets Swedish homeowners with heat pumps and battery systems, focusing on immediate value delivery with continuous learning.

---

## Week 1: Foundation & Strategic Planning (Jan 5-9)

### Day 3 (Jan 8) - Strategic Planning & Architecture Design [6h]
- **23:30-05:30**: Deep dive into Kiro CLI workflow and prompt ecosystem

### Day 4 (Jan 9) - Strategic Planning & Architecture Design [~6h]
- **16:00-:19:00**: Deep dive into Kiro CLI workflow and prompt ecosystem
- **23:30-03:46**: Collaborative product strategy refinement with AI assistants (Kiro + Gemini)
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
| Strategic Planning | 3h | 50% |
| Technical Architecture | 2h | 33% |
| Documentation | 1h | 17% |
| **Total** | **6h** | **100%** |

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

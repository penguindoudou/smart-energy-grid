# Plan Director: Comprehensive Project Plan Analysis

## Objective
Spawn parallel subagents to analyze and improve the current project plan (product.md, tech.md, structure.md) across key dimensions, focusing on MVP launch readiness and sustainable operations.

## Prerequisites
**IMPORTANT**: Run `@prime` first to load current project context before executing this prompt.

## Context & Constraints
- **Goal**: Launch lean, cost-effective MVP using AI coding agents
- **Priority**: Software-first solutions, minimal operational overhead
- **Timeline**: Fast iteration cycles leveraging coding automation
- **Budget**: Zero-cost operations where possible, minimal hosting costs

## Process

### Step 1: Create Output Directory
```bash
mkdir -p .kiro/analysis/plan_suggestions
```

### Step 2: Spawn Parallel Analysis Subagents

Launch 7 specialized subagents to analyze the project plan:

**Subagent 1: Quality & Reliability**
- Analyze expected product quality if current plan is executed
- Identify potential reliability risks and failure points
- Suggest quality assurance improvements
- Output: `01_quality_reliability.md`

**Subagent 2: Engineering Complexity**
- Evaluate over-engineering vs efficient complexity balance
- Identify areas where complexity adds value vs unnecessary overhead
- Suggest simplification opportunities without sacrificing core functionality
- Output: `02_engineering_complexity.md`

**Subagent 3: Cost & Sustainability**
- Analyze operational cost structure and sustainability
- Identify cost optimization opportunities
- Evaluate revenue model viability
- Output: `03_cost_sustainability.md`

**Subagent 4: Scalability**
- Assess scalability bottlenecks and growth limitations
- Suggest architecture improvements for future scale
- Identify when to optimize vs when to defer
- Output: `04_scalability.md`

**Subagent 5: User Experience**
- Evaluate user-friendliness and adoption barriers
- Suggest UX improvements for faster onboarding
- Identify friction points in user journey
- Output: `05_user_experience.md`

**Subagent 6: Social Impact**
- Analyze short-term and long-term positive impact potential
- Suggest ways to amplify beneficial outcomes
- Identify unintended consequences to mitigate
- Output: `06_social_impact.md`

**Subagent 7: Market Positioning**
- Evaluate compelling offer strength and differentiation
- Suggest positioning improvements and value proposition refinements
- Analyze competitive advantages and vulnerabilities
- Output: `07_market_positioning.md`

### Step 3: Subagent Instructions Template

Each subagent should:

1. **Read project context** from steering documents (product.md, tech.md, structure.md)
2. **Create analysis file** in `.kiro/analysis/plan_suggestions/` with assigned filename
3. **Structure suggestions** as:
   ```markdown
   # [Analysis Area] Suggestions
   
   ## Quick Wins (Implement Now)
   - [High-impact, low-effort improvements for MVP]
   
   ## MVP Enhancements (Pre-Launch)
   - [Important improvements before first release]
   
   ## Post-MVP Improvements (Future)
   - [Valuable but can wait until after launch]
   
   ## Risks & Concerns
   - [Potential issues with current approach]
   
   ## Rationale
   - [Why these suggestions matter for this analysis area]
   ```

4. **Focus on actionable suggestions** with clear implementation guidance
5. **Consider MVP constraints** - prioritize what enables launch vs future optimization

## Expected Outcome
7 specialized analysis files ready for synthesis into prioritized improvement roadmap.

## Next Step
After all subagents complete, run the synthesis prompt to create `summarized_improvements.md`.

# Plan Director: Comprehensive Project Plan Analysis

## Objective
Analyze and improve the current project plan (product.md, tech.md, structure.md) across key dimensions, focusing on MVP launch readiness and sustainable operations.

## Usage
- **Parallel Mode** (default): `@project-plan-director` or `@project-plan-director parallel`
- **Sequential Mode**: `@project-plan-director sequential`

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

### Step 2: Mode Selection

**If user specified "sequential" or no subagent tools available:**
Execute each analysis sequentially in main agent with web research capabilities:

1. **Quality & Reliability Analysis** → `01_quality_reliability.md`
2. **Engineering Complexity Analysis** → `02_engineering_complexity.md`  
3. **Cost & Sustainability Analysis** → `03_cost_sustainability.md`
4. **Scalability Analysis** → `04_scalability.md`
5. **User Experience Analysis** → `05_user_experience.md`
6. **Social Impact Analysis** → `06_social_impact.md`
7. **Market Positioning Analysis** → `07_market_positioning.md`

For each analysis:
- Conduct web research as needed for current trends/validation
- Apply analysis criteria (see Analysis Framework below)
- Create structured markdown file with findings

**If user specified "parallel" or default:**
Spawn 7 parallel subagents as described in Step 3.

### Step 3: Parallel Analysis (Default Mode)

Launch 7 specialized subagents to analyze the project plan:

**Subagent 1: Quality & Reliability**
- Analyze expected product quality if current plan is executed
- Identify potential reliability risks and failure points
- Suggest quality assurance improvements
- Output: `01_quality_reliability.md`

**Subagent 2: Engineering Complexity**
- Evaluate complexity trade-offs: high-value complexity vs unnecessary overhead
- Consider implementation feasibility with AI coding agents and available documentation
- Identify complexity that's worth adding (great value + easy to implement/verify)
- Flag complexity to avoid: frequent maintenance, instabilities, vulnerabilities, unjustified costs
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

### Step 4: Analysis Framework

**For both modes**, each analysis should:

1. **Read project context** from steering documents (product.md, tech.md, structure.md)
2. **Create analysis file** in `.kiro/analysis/plan_suggestions/` with assigned filename
3. **Apply complexity evaluation criteria**:
   - **Good complexity**: High value + easy to implement with AI coding agents + well-documented online + easy to verify results
   - **Bad complexity**: Frequent maintenance + instabilities + security vulnerabilities + costs users can't afford
   - **Implementation context**: Leverage AI coding agents' strengths and online documentation availability
4. **Structure suggestions** as:
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
   
   ## Research Needed
   - [Areas requiring web research for validation/implementation]
   - [Current technology trends to investigate]
   - [Competitive analysis gaps]
   - [Technical feasibility questions needing online verification]
   
   ## Rationale
   - [Why these suggestions matter for this analysis area]
   ```

4. **Focus on actionable suggestions** with clear implementation guidance
5. **Identify research gaps** - Flag areas where web research would validate assumptions or provide current market/technical data
6. **Focus on strategic complexity decisions** considering:
   - AI coding agent implementation capabilities
   - Availability of online documentation and examples
   - Verification and testing feasibility
   - Long-term maintenance burden vs value delivered
6. **Consider MVP constraints** - prioritize what enables launch vs future optimization

## Expected Outcome
7 specialized analysis files ready for synthesis into prioritized improvement roadmap, plus consolidated research agenda for follow-up web searches.

**Sequential Mode Benefits:**
- Web research integrated into each analysis
- More thorough current market/technology validation
- Better context between related analyses

**Parallel Mode Benefits:**
- Faster execution (5-10 minutes vs 15-20 minutes)
- Independent perspectives without bias
- Efficient for well-understood domains

## Next Step
After all subagents complete, run the synthesis prompt to create `summarized_improvements.md`.

# Independent Stack Analysis: Unbiased Stack Recommendations

## Objective
Analyze product requirements and suggest optimal tech stacks without bias from current technical decisions.

## Input Context
- **Product.md only** - No knowledge of current tech stack choices
- **Web search enabled** - Research current SOTA and proven approaches

## Analysis Framework

### 1. Product Requirements Analysis
Based on product.md, identify:
- Core functional requirements
- Performance requirements
- Scalability needs
- Integration requirements
- User experience priorities

### 2. Stack Research & Exploration
**Research both approaches using web search:**

**SOTA New Approaches:**
- Latest frameworks and technologies (2024-2026)
- Emerging patterns and architectures
- Cutting-edge solutions for similar products

**Proven Well-Tested Approaches:**
- Mature, battle-tested technologies
- Industry standard solutions
- Reliable, well-documented stacks

### 3. Stack Recommendations
For each recommended stack, provide:

#### Stack Components
- Frontend framework/library
- Backend framework/language
- Database solution
- Deployment/hosting approach
- Key integrations

#### Evaluation Criteria
- **Strengths**: What makes this stack ideal for our product?
- **Potential Flaws/Risks**: Known issues, limitations, concerns
- **Documentation Availability**: How easy is it to find implementation guidance?
- **Information Sources**: Where to find tutorials, examples, best practices?
- **AI Coding Agent Compatibility**: Is this in model training data? Well-documented online?

#### Strategic Considerations
- **Fast Functional MVP**: Can we ship quickly with this stack?
- **Reliability Pathway**: Can reliability be added incrementally, or must it be built from start?
- **Cost-Effectiveness**: Operational costs and hosting requirements
- **Scalability Evolution**: How does this stack grow from MVP to scale?
- **Migration Flexibility**: Lock-in risks and exit strategies

### 4. Context-Dependent Questions
For areas where additional context could affect recommendations:
- **Clear, easy-to-answer questions**
- **How each answer would modify the stack recommendation**
- **Impact on timeline and complexity**

## Output Structure
```markdown
# Independent Stack Analysis

## Product Requirements Summary
[Key requirements extracted from product.md]

## Recommended Stacks

### Option 1: [Stack Name - SOTA/Proven]
**Components**: [List]
**Strengths**: [List]
**Potential Flaws/Risks**: [List]
**Documentation & Learning**: [Assessment]
**Strategic Fit**: [MVP speed, reliability pathway, costs, scaling]

### Option 2: [Stack Name - SOTA/Proven]
[Same structure]

### Option 3: [Stack Name - SOTA/Proven]
[Same structure]

## Context-Dependent Decisions
- **Question**: [Specific question]
- **Impact**: [How answer affects stack choice]
- **Recommendation Variations**: [Different stacks for different answers]

## Assumptions Made
[List all assumptions about requirements, constraints, priorities]
```

## Output File
Create `independent_stack_analysis.md` in `.kiro/analysis/` folder.

## Success Criteria
- Unbiased analysis based purely on product requirements
- Mix of SOTA and proven approaches researched
- Clear documentation of assumptions and decision factors
- Actionable recommendations with clear trade-offs

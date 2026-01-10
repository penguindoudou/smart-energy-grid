# Tech Stack Synthesizer: Ultimate Stack Recommendation

## Objective
Synthesize findings from independent and current stack analyses to create the optimal stack recommendation for our scenario.

## Input Context
- **Product.md + Tech.md** - Full project context
- **independent_stack_analysis.md** - Unbiased stack recommendations
- **current_stack_analysis.md** - Current stack evaluation and alternatives
- **Web search enabled** - Research specific combinations and motivate your recommendations with sources

## Analysis Framework

### 1. Cross-Analysis Synthesis
Compare findings from both analyses:
- **Convergent Recommendations**: Where both analyses agree
- **Divergent Recommendations**: Where analyses differ and why
- **Complementary Insights**: How analyses inform each other
- **Gap Identification**: Missing considerations from either analysis

### 2. Stack Combination Exploration
Research whether stacks can be improved by combination:
- **Hybrid Approaches**: Best components from different stacks
- **Incremental Migration Paths**: Start with one, evolve to another
- **Component-Level Optimization**: Mix and match specific technologies
- **Integration Feasibility**: Technical compatibility of combinations

### 3. Ultimate Stack Recommendation
Based on synthesis, provide:

#### Recommended Stack Components
- **Frontend**: Framework/library choice with rationale
- **Backend**: Framework/language with rationale  
- **Database**: Solution with rationale
- **Deployment**: Hosting/infrastructure approach
- **Key Integrations**: Essential third-party services

#### Strategic Assessment
- **Strengths**: Why this is optimal for our scenario
- **Potential Flaws/Risks**: Honest assessment of limitations
- **Documentation & Learning**: Implementation guidance availability
- **Information Sources**: Where to find tutorials and examples

#### Implementation Strategy
- **Fast Functional MVP**: Timeline and approach for initial version
- **Reliability Pathway**: How to add reliability (incremental vs upfront)
- **Cost-Effectiveness**: Operational cost structure
- **Scalability Evolution**: Growth path from MVP to scale
- **Migration Flexibility**: Future evolution options

### 4. Scenario-Specific Recommendations
For different contexts that could affect the stack:
- **MVP-First Scenario**: Optimize for speed, reliability later
- **Reliability-First Scenario**: Build robust from start
- **High-Growth Scenario**: Optimize for rapid scaling
- **Resource-Constrained Scenario**: Minimize costs and complexity

### 5. Decision Validation
- **Assumption Verification**: Web research to validate key assumptions
- **Real-World Examples**: Find similar products using recommended stack
- **Community Validation**: Check current developer sentiment and trends

## Output Files
Create both files in `.kiro/analysis/` folder:

### synthesized_stack_analysis.md
```markdown
# Synthesized Stack Analysis

## Analysis Synthesis
**Convergent Findings**: [Where both analyses agreed]
**Divergent Findings**: [Where analyses differed]
**Resolution**: [How conflicts were resolved]

## Ultimate Stack Recommendation
**Components**: [Final stack with rationale for each]
**Strengths**: [Why optimal for our scenario]
**Potential Flaws/Risks**: [Honest limitations]
**Documentation & Support**: [Learning resources]

## Implementation Strategy
**MVP Approach**: [Fast functional path]
**Reliability Strategy**: [Incremental vs upfront]
**Cost Structure**: [Operational expenses]
**Scaling Path**: [Growth evolution]

## Scenario Variations
**MVP-First**: [Stack optimizations for speed]
**Reliability-First**: [Stack optimizations for robustness]
**High-Growth**: [Stack optimizations for scale]
**Resource-Constrained**: [Stack optimizations for efficiency]

## Assumptions & Context Dependencies
[Key assumptions and how context changes affect recommendations]
```

### synthesized_tech.md
[Updated version of tech.md with recommended stack]

## Success Criteria
- Clear synthesis of all previous analyses
- Justified ultimate recommendation with explicit trade-offs
- Practical implementation guidance
- Scenario-aware recommendations

# Tech Stack Evaluator: Current Stack Analysis

## Objective
Evaluate the current tech stack (tech.md) against product requirements and explore competitive alternatives.

## Input Context
- **Product.md + Tech.md** - Full context of current technical decisions
- **Web search enabled** - Research alternatives and evaluate current choices

## Analysis Framework

### 1. Current Stack Evaluation
Based on tech.md, analyze:

#### Strengths Assessment
- What works well in our current approach?
- Alignment with product requirements
- Implementation advantages
- Existing momentum and progress

#### Risk & Flaw Identification
- Potential bottlenecks or limitations
- Known issues with chosen technologies
- Scalability concerns
- Reliability risks
- Cost implications

#### Documentation & Support
- **Information Availability**: How easy is it to find implementation guidance?
- **Learning Resources**: Tutorials, examples, community support
- **AI Coding Agent Compatibility**: Coverage in model training data

### 2. Alternative Stack Research
**Research competitive alternatives using web search:**

**SOTA New Approaches:**
- Latest technologies that could replace current choices
- Modern alternatives to our current stack components
- Emerging patterns for similar products

**Proven Alternatives:**
- Mature alternatives to current choices
- Industry standard replacements
- Battle-tested solutions for our use case

### 3. Comparative Analysis
For each alternative stack:

#### Alternative Components
- How it differs from current stack
- Key technology substitutions
- Architecture changes required

#### Evaluation Criteria
- **Strengths vs Current**: What advantages does this offer?
- **Potential Flaws/Risks**: Limitations compared to current approach
- **Documentation Availability**: Learning curve and support
- **Information Sources**: Where to find implementation guidance
- **Migration Complexity**: Effort to switch from current stack

#### Strategic Considerations
- **Fast Functional MVP**: Speed compared to current approach
- **Reliability Pathway**: Better/worse reliability evolution than current
- **Cost-Effectiveness**: Operational cost comparison
- **Scalability Evolution**: Growth path vs current stack
- **Migration Flexibility**: Lock-in comparison

### 4. Justified Recommendations
Based on analysis:
- **Keep Current**: When current stack is optimal
- **Hybrid Approach**: Selective component upgrades
- **Full Migration**: When alternatives significantly better
- **Explicit Assumptions**: What we're assuming about priorities/constraints

### 5. Context-Dependent Decisions
Areas where more context could change recommendations:
- **Clear questions** about priorities, constraints, timeline
- **How answers would affect stack recommendations**
- **Different scenarios and their optimal stacks**

## Output Structure
```markdown
# Current Stack Analysis

## Current Stack Assessment
**Components**: [From tech.md]
**Strengths**: [What works well]
**Potential Flaws/Risks**: [Concerns and limitations]
**Documentation & Support**: [Learning resources assessment]

## Alternative Stacks Researched

### Alternative 1: [Stack Name - SOTA/Proven]
**Components**: [List]
**Advantages over Current**: [Specific benefits]
**Disadvantages vs Current**: [Trade-offs and risks]
**Migration Complexity**: [Effort assessment]
**Strategic Fit**: [MVP speed, reliability, costs, scaling vs current]

### Alternative 2: [Stack Name - SOTA/Proven]
[Same structure]

### Alternative 3: [Stack Name - SOTA/Proven]
[Same structure]

## Justified Recommendations
**Primary Recommendation**: [Keep/Hybrid/Migrate]
**Rationale**: [Why this choice for our context]
**Implementation Path**: [How to proceed]

## Context-Dependent Decisions
- **Question**: [Specific question]
- **Impact**: [How answer affects recommendation]
- **Scenario Variations**: [Different recommendations for different contexts]

## Assumptions Made
[List all assumptions about priorities, constraints, timeline]
```

## Output File
Create `current_stack_analysis.md` in `.kiro/analysis/` folder.

## Success Criteria
- Honest assessment of current stack strengths and weaknesses
- Well-researched alternatives with clear trade-offs
- Justified recommendations based on product context
- Clear migration complexity assessment

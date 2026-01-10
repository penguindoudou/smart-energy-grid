# Project Plan Enhancement Workflow

## Overview
A three-stage workflow to systematically analyze and improve project plans using parallel subagent analysis followed by intelligent synthesis.

## Usage
- **Parallel Mode** (default): `@project-plan-director` or `@project-plan-director parallel`  
- **Sequential Mode**: `@project-plan-director sequential`

**Mode Selection:**
- **Sequential**: Choose when you need current market research integrated into analysis, or when dealing with rapidly evolving technology domains
- **Parallel**: Choose for speed when project domain is well-understood and research needs can be addressed separately

**Primary Use Case**: Early project planning phase to validate and refine initial project plans (product.md, tech.md, structure.md) before significant development begins.

## Mode Comparison

| Aspect | Sequential Mode | Parallel Mode |
|--------|----------------|---------------|
| **Speed** | 15-20 minutes | 5-10 minutes |
| **Web Research** | Integrated per analysis | Flagged for follow-up |
| **Context Sharing** | Analyses can build on each other | Independent perspectives |
| **Best For** | Rapidly evolving domains, market research needs | Well-understood domains, speed priority |

## Workflow Steps

### Stage 1: Context Loading
```
@prime
```
**Purpose**: Load comprehensive project context including current implementation state, tech stack, and recent development focus.

**Output**: Full understanding of project status for informed analysis.

### Stage 2: Parallel Analysis
```
@project-plan-director
```
**Purpose**: Spawn 7 specialized subagents to analyze project plan across key dimensions:
- Quality & Reliability
- Engineering Complexity  
- Cost & Sustainability
- Scalability
- User Experience
- Social Impact
- Market Positioning

**Output**: 7 focused analysis files in `.kiro/analysis/plan_suggestions/`

**Quality Control**: Review generated files before synthesis to:
- Ensure all subagents completed successfully
- Verify analysis quality and relevance
- Remove or edit any suggestions that seem off-target
- Add any missing perspectives manually

### Stage 3: Synthesis & Prioritization
```
@plan-synthesis
```
**Purpose**: Consolidate all suggestions into prioritized, actionable roadmap.

**Output**: `summarized_improvements.md` with:
- Priority-ordered improvements
- Quick wins identification
- Implementation timeline
- Discarded suggestions with rationale
- Clarifying questions
- **Research agenda** with prioritized web research topics

## Quality Gates

### Before Synthesis
- [ ] All 7 analysis files generated
- [ ] Review each file for relevance and quality
- [ ] Edit or remove any inappropriate suggestions
- [ ] Ensure suggestions align with MVP/lean constraints

### After Synthesis
- [ ] Priorities make sense for current project phase
- [ ] Quick wins are genuinely actionable
- [ ] Discarded suggestions are properly justified
- [ ] Implementation steps are specific and clear

## Customization Options

### Modify Analysis Scope
Edit `@project-plan-director` to:
- Add/remove analysis dimensions
- Adjust subagent instructions
- Change output file structure

### Control Synthesis Input
Before running `@plan-synthesis`:
- Manually edit analysis files in `.kiro/analysis/plan_suggestions/`
- Add your own analysis files following the same format
- Remove files you don't want included in synthesis

### Iterate on Results
- Re-run synthesis with modified inputs
- Create multiple synthesis versions for comparison
- Use synthesis output to refine original project plans

## Best Practices

1. **Run early in project lifecycle** - Most valuable during initial planning phase before major development begins
2. **Use for plan validation** - Catch potential issues in project strategy before they become expensive to fix
3. **Run when major changes occur** to project scope, tech stack, or market conditions
4. **Review intermediate outputs** - don't blindly trust all subagent suggestions
5. **Focus on actionability** - prefer specific, implementable suggestions
6. **Balance perfectionism vs shipping** - prioritize MVP launch readiness
7. **Document decisions** - track which suggestions you implement and why

## Expected Timeline
- Stage 1 (Context): 2-3 minutes
- Stage 2 (Analysis): 5-10 minutes (parallel execution)
- Stage 3 (Synthesis): 3-5 minutes
- **Total**: ~15 minutes for comprehensive plan analysis

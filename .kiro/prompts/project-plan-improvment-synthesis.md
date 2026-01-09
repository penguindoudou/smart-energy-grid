# Plan Synthesis: Consolidate Project Improvement Suggestions

## Objective
Analyze all subagent suggestions from plan analysis and create a prioritized, actionable improvement roadmap.

## Prerequisites
**IMPORTANT**: Run `@project-plan-director` first to generate all analysis files.

## Process

### Step 1: Read All Analysis Files
Read all suggestion files from `.kiro/analysis/plan_suggestions/`:
- `01_quality_reliability.md`
- `02_engineering_complexity.md`
- `03_cost_sustainability.md`
- `04_scalability.md`
- `05_user_experience.md`
- `06_social_impact.md`
- `07_market_positioning.md`

### Step 2: Cross-Analysis Synthesis
Identify patterns, conflicts, and synergies across all suggestions:
- **Recurring themes** mentioned by multiple subagents
- **Conflicting recommendations** that need resolution
- **Synergistic improvements** that amplify each other
- **Resource dependencies** between suggestions

### Step 3: Create Consolidated Roadmap
Generate `summarized_improvements.md` with this structure:

```markdown
# Project Plan Improvement Roadmap

## Executive Summary
[2-3 sentences on overall assessment and key themes]

## Priority 1: Critical for MVP Launch
### [Improvement Name]
- **Impact**: [Why this matters for MVP success]
- **Effort**: [Implementation complexity/time]
- **Rationale**: [Evidence from multiple analyses]
- **Implementation**: [Specific next steps]

## Priority 2: MVP Enhancement (Pre-Launch)
[Same structure as Priority 1]

## Priority 3: Post-MVP Growth
[Same structure as Priority 1]

## Quick Wins (Implement Immediately)
- [High-impact, low-effort items that can be done now]

## Discarded Suggestions
### [Suggestion Name]
- **Reason**: [Why not recommended given current constraints]
- **Future Consideration**: [When this might become relevant]

## Clarifying Questions
- [Areas where more information is needed before deciding]
- [Trade-offs that require user input/decision]

## Implementation Timeline
[Suggested order of execution with rough timeframes]
```

### Step 4: Quality Criteria
Ensure the synthesis:
- **Prioritizes MVP launch readiness** over perfect solutions
- **Balances quick wins** with strategic improvements  
- **Provides clear rationale** for each priority level
- **Identifies dependencies** between improvements
- **Flags genuine conflicts** requiring decisions
- **Stays actionable** with specific next steps

## Expected Outcome
Single consolidated document that transforms 7 specialized analyses into a clear, prioritized action plan for improving the project plan while maintaining MVP focus and lean operations.

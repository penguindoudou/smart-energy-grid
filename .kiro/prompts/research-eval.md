# Research Report Evaluator

Critically evaluate the accuracy of quotes and conclusions in a research report. **Be skeptical and conservative** - flag any claims that cannot be definitively verified from sources.

## File Location Logic
When user provides just a filename (no path):
1. **Check analysis/ folder first** for the file
2. **If technical integration topic** (API, Modbus, protocols, device communication): look in `/analysis/integrations/`
3. **For other topics**: check other analysis subfolders
4. **Extract all quotes** from the report with their claimed sources
5. **Visit each source** and verify:
   - Quote accuracy (exact match or reasonable paraphrase)
   - Context validity (does full source context support the claim?)
6. **Apply critical scrutiny** - if evidence is ambiguous, incomplete, or contradictory, flag it
7. **Save evaluation**:
   - **No issues found**: Save in a subfolder with filename based on the original name `eval/{orginal filename}_eval_{version}.md`, check the path first to determine the version. For example if if a file ending with '_eval_1.md' or '_eval.md' save the new file `eval/{orginal filename}_eval_2.md`.
   - **Issues found**: Save in `critic_eval/` subfolder, use the same saving logic as above with `_critic_eval_{version}` instead of `_eval_{version}` and request the original prompt that generated the report for improvement suggestions

### 5. Balanced Skepticism
## Apply Proportional Scrutiny
- Flag clear contradictions and impossible claims
- Note unverifiable items without assuming malicious intent
- Distinguish between "cannot verify" vs "definitely false"
- Focus on claims that would materially impact decision-making

## Output Format
```
## Quote Accuracy Check
- Quote 1: [ACCURATE/INACCURATE/UNVERIFIABLE] - [brief explanation]
- Quote 2: [ACCURATE/INACCURATE/UNVERIFIABLE] - [brief explanation]

## Conclusion Validity
- Conclusion 1: [VALID/INVALID/UNSUPPORTED] - [reasoning based on full source context]
- Conclusion 2: [VALID/INVALID/UNSUPPORTED] - [reasoning based on full source context]

## Critical Issues Found
- [List any hallucinations, unsupported claims, or misleading statements]
- [Note missing context or cherry-picked information]

## Overall Assessment
[Conservative evaluation of report reliability - err on the side of caution]
```

## Evaluation Standards
- **ACCURATE**: Exact quote or faithful paraphrase with proper context
- **INACCURATE**: Misquoted, taken out of context, or contradicted by source
- **UNVERIFIABLE**: Source unavailable, unclear, or doesn't contain the claimed information
- **VALID**: Conclusion logically follows from verified evidence
- **INVALID**: Conclusion contradicted by evidence or based on false premises
- **UNSUPPORTED**: Insufficient evidence to support the conclusion
- **PARTIALLY ACCURATE**: Core claim correct but details may vary (e.g., exact numbers, timing)

- **Time Awareness** Be sure to check the of the report to understand the context.


---
**Usage**: 
- `@research-eval filename.md` - Evaluates file using intelligent location logic
- `@research-eval path/to/file.md` - Evaluates file at specific path
- Creates evaluation report in `eval/` subfolder (no issues) or `critic_eval/` subfolder (issues found), with naming conventions specified above

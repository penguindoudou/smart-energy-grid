#!/bin/bash
# verify_quotes.sh - Verify quotes in notebook.md and mark with ✅/❌

mkdir -p verified_sources

# Process notebook.md line by line
while IFS= read -r line; do
    if [[ $line =~ \*\*Quote\ from\*\*:\ (.+)\.md ]]; then
        source_file="sources/${BASH_REMATCH[1]}.md"
        filename="${BASH_REMATCH[1]}"
        
        # Read the quote (next line starting with >)
        read -r quote_line
        quote_text="${quote_line#> }"
        
        if [[ -f "$source_file" ]] && grep -Fq "$quote_text" "$source_file"; then
            # Mark as verified and move source
            echo "**Quote from**: ${filename}.md ✅"
            mv "$source_file" "verified_sources/"
        else
            # Mark as failed
            echo "**Quote from**: ${filename}.md ❌"
        fi
    else
        echo "$line"
    fi
done < notebook.md > notebook_verified.md

mv notebook_verified.md notebook.md
echo "Verification complete. Verified sources moved to verified_sources/"

#!/bin/bash
# Jina AI helper functions for intelligent research

# Load environment
source .env

# Jina search function
jina_search() {
    local query="$1"
    local encoded_query=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$query'))")
    echo "🔍 Searching: $query"
    curl -s "https://s.jina.ai/?q=$encoded_query" \
        -H "Authorization: Bearer $JINA_API_KEY" \
        -H "X-Respond-With: no-content"
}

# Jina read function - shows content in context for analysis
jina_read() {
    local url="$1"
    echo "📖 Reading: $url"
    curl -s "https://r.jina.ai/$url" \
        -H "Authorization: Bearer $JINA_API_KEY"
}

# Save source - only save if relevant after reading
save_source() {
    local url="$1"
    local filename="$2"
    mkdir -p sources
    echo "💾 Saving $url as sources/$filename.md"
    jina_read "$url" > "sources/$filename.md"
    echo "✅ Saved: sources/$filename.md"
}

# Extract quote - preview quote in context before saving
extract_quote() {
    local search_term="$1"
    local filename="$2"
    local before="${3:-1}"
    local after="${4:-2}"
    
    echo "📝 Previewing quote for '$search_term' from $filename:"
    grep -i "$search_term" "sources/$filename.md" -A$after -B$before
}

# Save quote - commit quote to quotes.md after evaluation
save_quote() {
    local search_term="$1"
    local filename="$2"
    local before="${3:-1}"
    local after="${4:-2}"
    
    # Add source header if not already present for this file
    if ! grep -q "## Source: $filename.md" quotes.md 2>/dev/null; then
        echo "" >> quotes.md
        echo "## Source: $filename.md" >> quotes.md
        echo "**URL**: $(grep "URL Source:" sources/$filename.md | head -1 | cut -d' ' -f3-)" >> quotes.md
        echo "**Date**: $(date '+%Y-%m-%d %H:%M')" >> quotes.md
        echo "" >> quotes.md
    fi
    
    # Save the quote
    echo "### Quote: \"$search_term\"" >> quotes.md
    grep -i "$search_term" "sources/$filename.md" -A$after -B$before >> quotes.md
    echo "" >> quotes.md
    echo "---" >> quotes.md
    
    echo "✅ Quote saved to quotes.md"
}

# Extract quote function
extract_quote() {
    local search_term="$1"
    local filename="$2"
    local before="${3:-1}"
    local after="${4:-2}"
    echo "📝 Extracting quote for '$search_term' from $filename:"
    grep -i "$search_term" "sources/$filename.md" -A$after -B$before
}

# List quotes - show all saved quotes for overview
list_quotes() {
    echo "📝 Saved Quotes:"
    grep "### Quote:" quotes.md 2>/dev/null | sed 's/### Quote: /- /' || echo "None saved yet"
}

#!/bin/bash
# Create shorter command aliases for Jina functions

cd /home/wisel/ubuntu_projects/observer
source .env
source .kiro/tools/jina_functions.sh

# Create aliases that can be called directly
alias js='jina_search'
alias jr='jina_read'  
alias ss='save_source'
alias eq='extract_quote'

# Export functions to make them available
export -f jina_search jina_read save_source extract_quote

echo "Jina aliases created: js, jr, ss, eq"

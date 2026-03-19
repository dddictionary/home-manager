#!/bin/bash

# Read query from stdin (JSON format: {"query": "search-term"})
query=$(cat | jq -r '.query')

# Use rg --files to list all files (respects .gitignore, fast)
# Pipe to fzf --filter for fuzzy matching and limit to 15 results
rg --files | fzf --filter "$query" | head -15

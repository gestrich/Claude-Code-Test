#!/bin/bash

# Check if input file exists
if [ ! -f "$1" ]; then
    echo "⚠️ *Input file not found*"
    exit 1
fi

# Parse the specified JSON file
if [ -f "$1" ]; then
    result=$(jq -r '.[] | select(.role == "system" and has("result")) | .result' "$1")
    
    if [ ! -z "$result" ]; then
        echo "$result"
        exit 0
    fi
fi

echo "⚠️ *Claude Code completed but did not generate a review.*"
exit 1 
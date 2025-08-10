#!/bin/bash

API_URL="https://pokeapi.co/api/v2/pokemon/pikachu"
OUTPUT_FILE="data.json"
ERROR_FILE="errors.txt"

# Make request
curl -s "$API_URL" -o "$OUTPUT_FILE"

# Check if request succeeded
if [ $? -ne 0 ] || [ ! -s "$OUTPUT_FILE" ]; then
    echo "Error fetching data for Pikachu at $(date)" >> "$ERROR_FILE"
    exit 1
fi

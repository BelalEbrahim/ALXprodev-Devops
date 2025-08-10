#!/bin/bash

INPUT_DIR="pokemon_data"
REPORT_FILE="pokemon_report.csv"

echo "Name,Height (m),Weight (kg)" > "$REPORT_FILE"

for FILE in "$INPUT_DIR"/*.json; do
    NAME=$(jq -r '.name' "$FILE" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')
    HEIGHT=$(jq -r '.height' "$FILE" | awk '{print $1/10}')
    WEIGHT=$(jq -r '.weight' "$FILE" | awk '{print $1/10}')
    echo "$NAME,$HEIGHT,$WEIGHT" >> "$REPORT_FILE"
done

echo "CSV Report generated at: $REPORT_FILE"
awk -F',' 'NR>1 {h+=$2; w+=$3; count++} END {print "Average Height: " h/count " m"; print "Average Weight: " w/count " kg"}' "$REPORT_FILE"


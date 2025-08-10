#!/bin/bash

JSON_FILE="data.json"

NAME=$(jq -r '.name' "$JSON_FILE" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')
HEIGHT=$(jq -r '.height' "$JSON_FILE" | awk '{print $1/10}') # decimetres to metres
WEIGHT=$(jq -r '.weight' "$JSON_FILE" | awk '{print $1/10}') # hectograms to kg
TYPE=$(jq -r '.types[0].type.name' "$JSON_FILE" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')

echo "$NAME is of type $TYPE, weighs ${WEIGHT}kg, and is ${HEIGHT}m tall."

Task 2 – Batch Pokémon Data Retrieval

#!/bin/bash

POKEMONS=("bulbasaur" "ivysaur" "venusaur" "charmander" "charmeleon")
OUTPUT_DIR="pokemon_data"
mkdir -p "$OUTPUT_DIR"

for POKE in "${POKEMONS[@]}"; do
    echo "Fetching data for $POKE..."
    FILE_PATH="$OUTPUT_DIR/${POKE}.json"
    
    if curl -s "https://pokeapi.co/api/v2/pokemon/$POKE" -o "$FILE_PATH"; then
        echo "Saved data to $FILE_PATH ✅"
    else
        echo "Failed to fetch $POKE" >> errors.txt
    fi

    sleep 2  # delay to avoid rate limiting
done

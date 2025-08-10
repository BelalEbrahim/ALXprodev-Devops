#!/bin/bash

POKEMONS=("bulbasaur" "ivysaur" "venusaur" "charmander" "charmeleon")
OUTPUT_DIR="pokemon_data"
mkdir -p "$OUTPUT_DIR"

fetch_pokemon() {
    local POKE=$1
    FILE_PATH="$OUTPUT_DIR/${POKE}.json"
    if curl -s "https://pokeapi.co/api/v2/pokemon/$POKE" -o "$FILE_PATH"; then
        echo "Saved data to $FILE_PATH ✅"
    else
        echo "Failed to fetch $POKE" >> errors.txt
    fi
}

for POKE in "${POKEMONS[@]}"; do
    echo "Fetching data for $POKE..."
    fetch_pokemon "$POKE" &
done

wait
echo "All downloads completed."


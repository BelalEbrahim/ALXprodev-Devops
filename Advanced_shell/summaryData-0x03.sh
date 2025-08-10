#!/bin/bash

POKEMONS=("bulbasaur" "ivysaur" "venusaur" "charmander" "charmeleon")
OUTPUT_DIR="pokemon_data"
mkdir -p "$OUTPUT_DIR"

for POKE in "${POKEMONS[@]}"; do
    echo "Fetching data for $POKE..."
    FILE_PATH="$OUTPUT_DIR/${POKE}.json"
    ATTEMPT=1
    SUCCESS=false

    while [ $ATTEMPT -le 3 ]; do
        if curl -s "https://pokeapi.co/api/v2/pokemon/$POKE" -o "$FILE_PATH" && [ -s "$FILE_PATH" ]; then
            echo "Saved data to $FILE_PATH ✅"
            SUCCESS=true
            break
        else
            echo "Attempt $ATTEMPT failed for $POKE. Retrying..."
            sleep 2
        fi
        ((ATTEMPT++))
    done

    if [ "$SUCCESS" = false ]; then
        echo "Failed to fetch $POKE after 3 attempts" >> errors.txt
    fi
done

#!/bin/bash

arg=$1

if [ "$arg" = "images" ]; then
    export CI=true 

    IMAGES=($(echo "$PLUGIN_IMAGES" | tr "," "\n"))
    # IMAGES=$(echo "$PLUGIN_IMAGES" | sed -r 's/[^,]+/"&"/g')

    for image in ${IMAGES[@]}; do 
        echo "dive '${image}'"
        dive "${image}"
        # dive "${image}" --source podman
    done
else 
    export CI=true 
    echo "dive '$@'"
fi
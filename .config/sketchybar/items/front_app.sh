#!/bin/bash

sketchybar --add item front_app left \
        --set front_app \
            icon.drawing=on \
            script="$PLUGIN_DIR/front_app.sh" \
        --subscribe front_app front_app_switched

#!bin/bash

SPACE_SIDS=(1 2 3 4 5 6 7 8 9 10)
for sid in "${SPACE_SIDS[@]}"
do
    sketchybar --add space space.$sid left \
        --set space.$sid space=$sid \
                        icon=$sid \
                        label.padding_right=20 \
                        label.y_offset=0 \
                        script="$PLUGIN_DIR/space.sh"
                    done

#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/i3"
OUTPUT="$CONFIG_DIR/config"

# Concatenate the config files in the following order
# base + border

cat "$CONFIG_DIR/default.conf" \
    "$CONFIG_DIR/border/default.conf" \
    > "$OUTPUT"

# Reload i3
i3-msg reload

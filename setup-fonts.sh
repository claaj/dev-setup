#!/bin/bash

NERD_FONTS_VERSION="v3.3.0"

URL="https://github.com/ryanoasis/nerd-fonts/releases/download/$NERD_FONTS_VERSION/JetBrainsMono.zip"

FONT_DIR="$HOME/.local/share/fonts"

mkdir -p "$FONT_DIR"

curl -L -o "/tmp/JetBrainsMono.zip" "$URL"

unzip -o "/tmp/JetBrainsMono.zip" -d "$FONT_DIR"

rm "/tmp/JetBrainsMono.zip"

fc-cache -f "$FONT_DIR"

echo "Fonts installed and cache updated!"

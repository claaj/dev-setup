#!/bin/bash

NERD_FONTS_VERSION="v3.4.0"

URL="https://github.com/ryanoasis/nerd-fonts/releases/download/$NERD_FONTS_VERSION/AdwaitaMono.zip"

FONT_DIR="$HOME/.local/share/fonts"

mkdir -p "$FONT_DIR"

curl -L -o "/tmp/AdwaitaMono.zip" "$URL"

unzip -o "/tmp/AdwaitaMono.zip" -d "$FONT_DIR"

rm "/tmp/AdwaitaMono.zip"

fc-cache -f "$FONT_DIR"

echo "Fonts installed and cache updated!"

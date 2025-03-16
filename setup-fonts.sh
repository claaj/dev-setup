#!/bin/bash

IOSEVKA_VERSION="33.1.0"
NERD_FONTS_VERSION="v3.3.0"

URL1="https://github.com/be5invis/Iosevka/releases/download/v${IOSEVKA_VERSION}/SuperTTC-Iosevka-${IOSEVKA_VERSION}.zip"
URL2="https://github.com/ryanoasis/nerd-fonts/releases/download/$NERD_FONTS_VERSION/NerdFontsSymbolsOnly.zip"

FONT_DIR="$HOME/.local/share/fonts"

mkdir -p "$FONT_DIR"

curl -L -o "/tmp/Iosevka.zip" "$URL1"

curl -L -o "/tmp/NerdFontsSymbolsOnly.zip" "$URL2"

unzip -o "/tmp/Iosevka.zip" -d "$FONT_DIR/Iosevka"
unzip -o "/tmp/NerdFontsSymbolsOnly.zip" -d "$FONT_DIR/NerdFontsSymbolsOnly"

rm "/tmp/Iosevka.zip" "/tmp/NerdFontsSymbolsOnly.zip"

fc-cache -f "$FONT_DIR"

echo "Fonts installed and cache updated!"

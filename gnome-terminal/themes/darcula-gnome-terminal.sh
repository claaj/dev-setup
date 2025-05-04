#!/usr/bin/env bash

# GNOME Terminal theme based on Lua colorscheme definition
# Generated from the provided Lua 'my_colors' table

# --- Configuration ---
# Set to true to attempt setting bold text to use bright colors, false to use normal colors + bold font
USE_BRIGHT_FOR_BOLD=true
# --- End Configuration ---

# Get default profile ID robustly
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
if [[ -z "$PROFILE_ID" ]]; then
    echo "Error: Could not retrieve default profile ID."
    exit 1
fi
PROFILE_PATH="/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/"

# Backup current profile with timestamp
BACKUP_FILE="gnome-terminal-lua-colors-backup-$(date +%Y%m%d_%H%M%S).txt"
echo "Backing up profile $PROFILE_ID ($PROFILE_PATH) to $BACKUP_FILE..."
dconf dump "$PROFILE_PATH" > "$BACKUP_FILE"
if [[ $? -ne 0 ]]; then
    echo "Warning: Failed to create backup file. Continuing..."
    # Decide if you want to exit or continue
    # exit 1
fi

# Color definitions from the Lua 'my_colors' table
BACKGROUND="#212121"
FOREGROUND="#abb2bf"
CURSOR_FG="#212121"   # Lua: cursor_fg
CURSOR_BG="#abb2bf"   # Lua: cursor_bg
SELECTION_BG="#2c313a" # Lua: selection_bg
SELECTION_FG="#abb2bf" # Lua: selection_fg

# Terminal Palette Colors (COLOR_0 to COLOR_15) from Lua 'ansi' and 'brights'
# Normal colors (ansi array)
COLOR_0="#2C2C2C"  # Black
COLOR_1="#f43753"  # Red
COLOR_2="#6A8759"  # Green
COLOR_3="#ffc24b"  # Yellow
COLOR_4="#61AFEF"  # Blue
COLOR_5="#9876AA"  # Magenta
COLOR_6="#00f1f5"  # Cyan
COLOR_7="#abb2bf"  # White

# Bright colors (brights array)
COLOR_8="#555555"  # Bright Black
COLOR_9="#FF6B81"  # Bright Red
COLOR_10="#98be65" # Bright Green
COLOR_11="#FFD073" # Bright Yellow
COLOR_12="#7BC8FF" # Bright Blue
COLOR_13="#B490D0" # Bright Magenta
COLOR_14="#50FDFF" # Bright Cyan
COLOR_15="#eeeeee" # Bright White

# Create color palette string for dconf
PALETTE="['$COLOR_0', '$COLOR_1', '$COLOR_2', '$COLOR_3', '$COLOR_4', '$COLOR_5', '$COLOR_6', '$COLOR_7', '$COLOR_8', '$COLOR_9', '$COLOR_10', '$COLOR_11', '$COLOR_12', '$COLOR_13', '$COLOR_14', '$COLOR_15']"

# Apply settings using dconf write
echo "Applying Lua-defined colors theme to profile $PROFILE_ID..."

# Disable theme colors to use our custom scheme
dconf write "${PROFILE_PATH}use-theme-colors" "false"

# Set background and foreground
dconf write "${PROFILE_PATH}background-color" "'$BACKGROUND'"
dconf write "${PROFILE_PATH}foreground-color" "'$FOREGROUND'"

# Set cursor colors (Foreground and Background)
dconf write "${PROFILE_PATH}cursor-foreground-color" "'$CURSOR_FG'"
dconf write "${PROFILE_PATH}cursor-background-color" "'$CURSOR_BG'"
dconf write "${PROFILE_PATH}cursor-colors-set" "true"

# Set selection/highlight colors
dconf write "${PROFILE_PATH}highlight-background-color" "'$SELECTION_BG'"
dconf write "${PROFILE_PATH}highlight-foreground-color" "'$SELECTION_FG'"
dconf write "${PROFILE_PATH}highlight-colors-set" "true" # Use custom highlight colors

# Apply the 16-color palette
dconf write "${PROFILE_PATH}palette" "$PALETTE"

# Configure bold text behavior
if [[ "$USE_BRIGHT_FOR_BOLD" = true ]]; then
    dconf write "${PROFILE_PATH}bold-color-same-as-fg" "false"
    # Optionally force bold font off if using bright colors for intensity
    # dconf write "${PROFILE_PATH}use-bold-font" "false" # Uncomment if needed
else
    dconf write "${PROFILE_PATH}bold-color-same-as-fg" "true"
    dconf write "${PROFILE_PATH}use-bold-font" "true" # Ensure bold font is used
fi

# Optional: Set profile name
dconf write "${PROFILE_PATH}visible-name" "'Lua Colors Adapted'"

echo "Theme based on Lua colors should now be applied to your GNOME Terminal profile '$PROFILE_ID'."
echo "A backup of your previous settings was saved to $BACKUP_FILE"

exit 0

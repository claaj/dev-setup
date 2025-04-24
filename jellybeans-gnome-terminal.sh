#!/usr/bin/env bash

# GNOME Terminal theme based on the "jellybeans" color scheme

# --- Configuration ---
# Set to true to attempt setting bold text to use bright colors, false to use normal colors + bold font
USE_BRIGHT_FOR_BOLD=true
PROFILE_VISIBLE_NAME="jellybeans" # Name for the profile in GNOME Terminal
# --- End Configuration ---

# Get default profile ID robustly
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
if [[ -z "$PROFILE_ID" ]]; then
    echo "Error: Could not retrieve default profile ID."
    exit 1
fi
PROFILE_PATH="/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/"

# Backup current profile with timestamp
BACKUP_FILE="gnome-terminal-backup-${PROFILE_ID}-$(date +%Y%m%d_%H%M%S).txt"
echo "Backing up profile $PROFILE_ID ($PROFILE_PATH) to $BACKUP_FILE..."
dconf dump "$PROFILE_PATH" > "$BACKUP_FILE"
if [[ $? -ne 0 ]]; then
    echo "Warning: Failed to create backup file $BACKUP_FILE. Continuing..."
    # Decide if you want to exit or continue if backup fails
    # exit 1
fi

# === Color definitions for "jellybeans" ===
BACKGROUND="#151515"     # Lua: background
FOREGROUND="#e8e8d3"     # Lua: foreground
CURSOR_FG="#151515"      # Lua: cursor_fg
CURSOR_BG="#e8e8d3"      # Lua: cursor_bg
SELECTION_BG="#888888"   # Lua: selection_bg
SELECTION_FG="#151515"   # Lua: selection_fg

# Terminal Palette Colors (COLOR_0 to COLOR_15) from Lua 'ansi' and 'brights'
# Normal colors (ansi array)
COLOR_0="#101010"  # Black
COLOR_1="#B05050"  # Red
COLOR_2="#99ad6a"  # Green
COLOR_3="#dad085"  # Yellow
COLOR_4="#8197bf"  # Blue
COLOR_5="#c6b6ee"  # Magenta
COLOR_6="#2B5B77"  # Cyan
COLOR_7="#c7c7c7"  # White

# Bright colors (brights array)
COLOR_8="#404040"  # Bright Black
COLOR_9="#cf6a4c"  # Bright Red
COLOR_10="#99ad6a" # Bright Green
COLOR_11="#ffb964" # Bright Yellow
COLOR_12="#8fbfdc" # Bright Blue
COLOR_13="#c6b6ee" # Bright Magenta
COLOR_14="#668799" # Bright Cyan
COLOR_15="#ffffff" # Bright White
# === End Color definitions ===

# Create color palette string for dconf
PALETTE="['$COLOR_0', '$COLOR_1', '$COLOR_2', '$COLOR_3', '$COLOR_4', '$COLOR_5', '$COLOR_6', '$COLOR_7', '$COLOR_8', '$COLOR_9', '$COLOR_10', '$COLOR_11', '$COLOR_12', '$COLOR_13', '$COLOR_14', '$COLOR_15']"

# Apply settings using dconf write
echo "Applying theme '$PROFILE_VISIBLE_NAME' to profile $PROFILE_ID..."

# Disable theme colors to use our custom scheme
dconf write "${PROFILE_PATH}use-theme-colors" "false"

# Set background and foreground
dconf write "${PROFILE_PATH}background-color" "'$BACKGROUND'"
dconf write "${PROFILE_PATH}foreground-color" "'$FOREGROUND'"

# Set cursor colors (Foreground and Background)
dconf write "${PROFILE_PATH}cursor-foreground-color" "'$CURSOR_FG'"
dconf write "${PROFILE_PATH}cursor-background-color" "'$CURSOR_BG'"
# Enable custom cursor colors (important!)
dconf write "${PROFILE_PATH}cursor-colors-set" "true"

# Set selection/highlight colors
dconf write "${PROFILE_PATH}highlight-background-color" "'$SELECTION_BG'"
dconf write "${PROFILE_PATH}highlight-foreground-color" "'$SELECTION_FG'"
# Enable custom highlight colors (important!)
dconf write "${PROFILE_PATH}highlight-colors-set" "true"

# Apply the 16-color palette
dconf write "${PROFILE_PATH}palette" "$PALETTE"

# Configure bold text behavior
if [[ "$USE_BRIGHT_FOR_BOLD" = true ]]; then
    # Use the corresponding bright color for bold text
    dconf write "${PROFILE_PATH}bold-color-same-as-fg" "false"
    # Optional: Turn off using a bold *font* if bright colors provide enough emphasis
    # dconf write "${PROFILE_PATH}use-bold-font" "false"
else
    # Use the foreground color but with a bold font weight
    dconf write "${PROFILE_PATH}bold-color-same-as-fg" "true"
    # Ensure bold font is explicitly enabled if not using bright colors for intensity
    dconf write "${PROFILE_PATH}use-bold-font" "true"
fi

# Set profile name
dconf write "${PROFILE_PATH}visible-name" "'$PROFILE_VISIBLE_NAME'"

echo "Theme '$PROFILE_VISIBLE_NAME' should now be applied to your default GNOME Terminal profile '$PROFILE_ID'."
echo "A backup of your previous settings was saved to $BACKUP_FILE (if successful)."

exit 0

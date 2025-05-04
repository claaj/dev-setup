#!/usr/bin/env bash

# Carbonfox theme for GNOME Terminal
# Based on nightfox.nvim carbonfox theme

# Reset and backup current profile
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
dconf dump /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ > gnome-terminal-backup.txt

# Color definitions
BACKGROUND="#161616"
FOREGROUND="#f2f4f8"
CURSOR="#f2f4f8"
SELECTION_BG="#2a2a2a"
SELECTION_FG="#f2f4f8"

# Normal colors
COLOR_0="#282828"  # Black
COLOR_1="#ee5396"  # Red
COLOR_2="#25be6a"  # Green
COLOR_3="#08bdba"  # Yellow
COLOR_4="#78a9ff"  # Blue
COLOR_5="#be95ff"  # Magenta
COLOR_6="#33b1ff"  # Cyan
COLOR_7="#dfdfe0"  # White

# Bright colors
COLOR_8="#484848"   # Bright Black
COLOR_9="#f16da6"   # Bright Red
COLOR_10="#46c880"  # Bright Green
COLOR_11="#2dc7c4"  # Bright Yellow
COLOR_12="#8cb6ff"  # Bright Blue
COLOR_13="#c8a5ff"  # Bright Magenta
COLOR_14="#52bdff"  # Bright Cyan
COLOR_15="#e4e4e5"  # Bright White

# Additional colors
COLOR_16="#3ddbd9"  # Teal
COLOR_17="#ff7eb6"  # Pink

# Create color array
PALETTE="['$COLOR_0', '$COLOR_1', '$COLOR_2', '$COLOR_3', '$COLOR_4', '$COLOR_5', '$COLOR_6', '$COLOR_7', '$COLOR_8', '$COLOR_9', '$COLOR_10', '$COLOR_11', '$COLOR_12', '$COLOR_13', '$COLOR_14', '$COLOR_15']"

# Apply settings
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/use-theme-colors "false"
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/background-color "'$BACKGROUND'"
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/foreground-color "'$FOREGROUND'"
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/cursor-background-color "'$CURSOR'"
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/cursor-colors-set "true"
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/highlight-background-color "'$SELECTION_BG'"
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/highlight-foreground-color "'$SELECTION_FG'"
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/highlight-colors-set "true"
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/palette "$PALETTE"

# Optional: Set profile name to Carbonfox
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/visible-name "'Carbonfox'"

echo "Carbonfox theme has been applied to your GNOME Terminal"
echo "A backup of your previous settings has been saved to gnome-terminal-backup.txt"

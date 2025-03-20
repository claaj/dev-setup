#!/usr/bin/env bash

# Reset and backup current profile
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
dconf dump /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ > gnome-terminal-backup.txt

# Color definitions
BACKGROUND="#000000"  # background
FOREGROUND="#d0d0d0"  # foreground
CURSOR="#ff76ff"      # cursor_bg and cursor_border
SELECTION_BG="#2a234a"  # selection_bg
SELECTION_FG="#d0d0d0"  # selection_fg

# Normal colors
COLOR_0="#000000"  # Black
COLOR_1="#ef6560"  # Red
COLOR_2="#0faa26"  # Green
COLOR_3="#bf9032"  # Yellow
COLOR_4="#3f95f6"  # Blue
COLOR_5="#d369af"  # Magenta
COLOR_6="#6fafff"  # Cyan
COLOR_7="gray65"   # White

# Bright colors
COLOR_8="gray35"   # Bright Black
COLOR_9="#f47360"  # Bright Red
COLOR_10="#6aad0f" # Bright Green
COLOR_11="#df8a5a" # Bright Yellow
COLOR_12="#029fff" # Bright Blue
COLOR_13="#af85ff" # Bright Magenta
COLOR_14="#1dbfcf" # Bright Cyan
COLOR_15="white"   # Bright White

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

# Optional: Set profile name to ef-dark
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/visible-name "'ef-dark'"

echo "ef-dark theme has been applied to your GNOME Terminal"
echo "A backup of your previous settings has been saved to gnome-terminal-backup.txt"

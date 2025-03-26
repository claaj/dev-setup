#!/usr/bin/env bash

# Darcula theme for GNOME Terminal
# Based on JetBrains Darcula color scheme

# Reset and backup current profile
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
dconf dump /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ > gnome-terminal-darcula-backup.txt

# Color definitions
BACKGROUND="#2b2b2b"
FOREGROUND="#a9b7c6"
CURSOR="#a9b7c6"
SELECTION_BG="#323232"
SELECTION_FG="#a9b7c6"

# Normal colors
COLOR_0="#2b2b2b"  # Black
COLOR_1="#4eade5"  # Red (actually cyan-blue)
COLOR_2="#6a8759"  # Green (string)
COLOR_3="#bbb529"  # Yellow
COLOR_4="#9876aa"  # Blue (actually purple)
COLOR_5="#cc7832"  # Magenta (actually orange)
COLOR_6="#689757"  # Cyan (actually green-blue)
COLOR_7="#a9b7c6"  # White

# Bright colors
COLOR_8="#323232"   # Bright Black (line cursor)
COLOR_9="#4eade5"   # Bright Red (same as normal)
COLOR_10="#6a8759"  # Bright Green (same as normal)
COLOR_11="#ffc66d"  # Bright Yellow (function highlight)
COLOR_12="#9876aa"  # Bright Blue (same as normal)
COLOR_13="#cc7832"  # Bright Magenta (same as normal)
COLOR_14="#629755"  # Bright Cyan (comment)
COLOR_15="#ffffff"  # Bright White

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

# Optional: Set profile name to Darcula
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/visible-name "'Darcula'"

echo "Darcula theme has been applied to your GNOME Terminal"
echo "A backup of your previous settings has been saved to gnome-terminal-darcula-backup.txt"

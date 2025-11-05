#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# GNOME App Grid Categorizer
# Uses .directory files + translate=true for full localization
# =============================================================================

# --- Folder Configuration: [folder_id] = "name_base|categories|translate"
#     name_base     → value for `name` key (must match .directory filename)
#     categories    → comma-separated list in ['A', 'B']
#     translate     → 'true' or 'false'
declare -A FOLDERS=(
    ["utility"]="Utility.directory|['Utility']|true"
    ["web-applications"]="X-GNOME-WebApplications.directory|['chrome-apps']|true"
    ["game"]="Game.directory|['Game']|true"
    ["graphics"]="Graphics.directory|['Graphics']|true"
    ["network"]="Network.directory|['Network', 'WebBrowser', 'Email']|true"
    ["office"]="Office.directory|['Office']|true"
    ["development"]="Development.directory|['Development']|true"
    ["education"]="Education.directory|['Science']|true"
    ["audio-video"]="AudioVideo.directory|['AudioVideo', 'Audio', 'Video']|true"
    ["system-tools"]="System-Tools.directory|['System', 'Settings']|true"
    ["utility-accessibility"]="Utility-Accessibility.directory|['Accessibility']|true"
    ["waydroid"]="Waydroid|['Waydroid', 'X-WayDroid-App']|false"
    ["wine"]="Wine|['Wine', 'X-Wine', 'Wine-Programs-Accessories']|false"
)

# --- Order of folders in overview ---
FOLDER_ORDER=(
    utility
    web-applications
    game
    graphics
    network
    office
    development
    education
    audio-video
    system-tools
    utility-accessibility
    waydroid
    wine
)

# =============================================================================
# 1. Set folder order
# =============================================================================
order_array=$(printf "'%s'," "${FOLDER_ORDER[@]}")
order_array="[${order_array%,}]"
gsettings set org.gnome.desktop.app-folders folder-children "$order_array"

# =============================================================================
# 2. Configure each folder
# =============================================================================
for folder_id in "${FOLDER_ORDER[@]}"; do
    IFS='|' read -r name_base categories translate <<< "${FOLDERS[$folder_id]}"
    schema="org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/${folder_id}/"

    gsettings set "$schema" name "'$name_base'"
    gsettings set "$schema" translate "$translate"
    gsettings set "$schema" categories "$categories"
done

gsettings set org.gnome.shell app-picker-layout "[]"

echo "App folders configured successfully!"
echo "Restart GNOME Shell"
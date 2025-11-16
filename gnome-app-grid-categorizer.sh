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
    ["web-applications"]="X-GNOME-WebApplications.directory|['chrome-apps', 'WebApps', 'X-GNOME-WebApplication']|true"
    ["game"]="Game.directory|['Game']|true"
    ["graphics"]="Graphics.directory|['Graphics']|true"
    ["network"]="Network.directory|['Network', 'WebBrowser', 'Email']|true"
    ["office"]="Office.directory|['Office']|true"
    ["development"]="Development.directory|['Development']|true"
    ["education"]="Education.directory|['Science']|true"
    ["audio-video"]="AudioVideo.directory|['AudioVideo', 'Audio', 'Video']|true"
    ["system-tools"]="System-Tools.directory|['System', 'Settings']|true"
    ["utility-accessibility"]="Utility-Accessibility.directory|['Accessibility']|true"
    ["waydroid"]="waydroid.directory|['Waydroid', 'X-WayDroid-App']|true"
    ["wine"]="Wine|['Wine', 'X-Wine', 'Wine-Programs-Accessories']|false"
)

# --- Folders in overview ---
FOLDER_IDS=(
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

# Base dconf path
BASE_PATH="/org/gnome/desktop/app-folders/"

# =============================================================================
# 1. Clear all existing app folder data
# =============================================================================
dconf reset -f "$BASE_PATH"

# =============================================================================
# 2. Setup new folders
# =============================================================================
# Build array: ['utility', 'web-applications', ...]
folder_array=$(printf "'%s'," "${FOLDER_IDS[@]}")
folder_array="[${folder_array%,}]"

dconf write "${BASE_PATH}folder-children" "$folder_array"

# =============================================================================
# 3. Configure each folder
# =============================================================================
for folder_id in "${FOLDER_IDS[@]}"; do
    IFS='|' read -r name_base categories translate <<< "${FOLDERS[$folder_id]}"
    folder_path="${BASE_PATH}folders/${folder_id}/"

    dconf write "${folder_path}name" "'$name_base'"
    dconf write "${folder_path}translate" "$translate"
    dconf write "${folder_path}categories" "$categories"
done

echo "App folders configured successfully!"
echo "Restart GNOME Shell"
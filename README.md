# GNOME App Grid Categorizer

A bash script to configure GNOME Shell application folders with localization support using `.directory` files.

## Overview

This script automates the configuration of GNOME Shell's application folders. It creates organized folders for different application categories with proper localization support.

## Features

- **Localization Ready**: Uses GNOME's `translate=true` feature with `.directory` files for proper internationalization
- **Comprehensive Categories**: Pre-configured folders for common application types:
  - Utility & Accessibility
  - Web Applications & Chrome Apps
  - Games
  - Graphics & Multimedia
  - Network & Communication
  - Office & Productivity
  - Development Tools
  - Education & Science
  - Audio & Video
  - System Tools & Settings
  - Waydroid Applications
  - Wine Applications

## Prerequisites

- GNOME Shell (tested on GNOME 49)
- `dconf` command-line tool
- `gsettings` command-line tool (usually included with GNOME)
- `gnome-menus` GNOME menu specifications

## Installation

1. Clone this repository:
```bash
git clone https://github.com/7up4/gnome-app-grid-categorizer.git
cd gnome-app-grid-categorizer
```

2. Make the script executable:
```bash
chmod +x gnome-app-grid-categorizer.sh
```

## Usage

Run the script directly:

```bash
./gnome-app-grid-categorizer.sh
```

Or execute with bash:

```bash
bash gnome-app-grid-categorizer.sh
```

## What This Script Does

1. **Configures Each Folder**: Sets up proper names, categories, and translation settings
2. **Uses `.directory` Files**: Leverages GNOME's standard desktop entry system for localization

## Restarting GNOME Shell

After running the script, restart GNOME Shell to see changes:
- Press `Alt+F2`, type `r`, then press `Enter` (X11 session)
- Or log out and log back in

## Customization

You can easily modify the script to:

1. **Add/remove categories**: Modify the `FOLDERS` associative array
2. **Change category names**: Update the name base values
3. **Adjust categories**: Modify the category arrays

## Troubleshooting

- If folders don't appear, ensure you have the corresponding `.directory` files
- Check that applications are properly categorized with correct desktop entry categories

## License

MIT License - see LICENSE file for details

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for suggestions and bugs.
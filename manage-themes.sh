#!/bin/bash

# Define the source and destination directories
SOURCE_DIR="themes"
DEST_DIR="$HOME/Library/Developer/Xcode/UserData/FontAndColorThemes"

# List of available themes
THEMES=("Catppuccin Frappé" "Catppuccin Latte" "Catppuccin Macchiato" "Catppuccin Mocha")

# Function to display the theme list
function display_themes {
    echo "Available themes:"
    for i in "${!THEMES[@]}"; do
        echo "$((i + 1)). ${THEMES[$i]}"
    done
}

# Function to install a specific theme
function install_theme {
    THEME_NAME="$1.xccolortheme"
    if [ -f "$SOURCE_DIR/$THEME_NAME" ]; then
        cp "$SOURCE_DIR/$THEME_NAME" "$DEST_DIR"
        echo "Installed theme: $1"
    else
        echo "Theme '$1' not found in $SOURCE_DIR."
    fi
}

# Function to uninstall all themes
function uninstall_all_themes {
    for theme in "${THEMES[@]}"; do
        THEME_NAME="$theme.xccolortheme"
        if [ -f "$DEST_DIR/$THEME_NAME" ]; then
            rm "$DEST_DIR/$THEME_NAME"
            echo "Uninstalled theme: $theme"
        fi
    done
}

# Main script logic
echo "Do you want to install, uninstall, or exit?"
echo "1. Install themes"
echo "2. Uninstall themes"
echo "3. Exit"
read -p "Choose an option: " main_option

# Ensure destination directory exists
mkdir -p "$DEST_DIR"

case $main_option in
    1)
        echo "Do you want to install all themes or a specific one?"
        echo "1. Install all themes"
        echo "2. Install a specific theme"
        read -p "Choose an option: " install_option

        case $install_option in
            1)
                # Install all themes
                for theme in "${THEMES[@]}"; do
                    install_theme "$theme"
                done
                echo "All themes have been installed!"
                ;;
            2)
                # Install a specific theme
                display_themes
                read -p "Choose a theme by number: " theme_option
                if [[ $theme_option -ge 1 && $theme_option -le ${#THEMES[@]} ]]; then
                    chosen_theme="${THEMES[$((theme_option - 1))]}"
                    install_theme "$chosen_theme"
                else
                    echo "Invalid option."
                fi
                ;;
            *)
                echo "Invalid option. Exiting."
                exit 1
                ;;
        esac
        ;;
    2)
        # Uninstall all themes
        uninstall_all_themes
        echo "All themes have been uninstalled!"
        ;;
    3)
        echo "Exiting."
        exit 0
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac

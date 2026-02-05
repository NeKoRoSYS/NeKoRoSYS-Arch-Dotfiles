#!/bin/bash

# =============================================================================
# Arch Linux Rice Installation Script (AUR/yay version)
# Based on NeKoRoSYS-s-Arch-Linux-Rice
# =============================================================================

# Define colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting installation...${NC}"

# 1. Check for yay
if ! command -v yay &> /dev/null; then
    echo -e "${RED}Error: yay is not installed. Please install an AUR helper to continue.${NC}"
    exit 1
fi

# 2. Replace all hardcoded usernames
echo -e "${BLUE}Updating paths for user: $USER...${NC}"
find . -type f -exec sed -i "s|/home/nekorosys|/home/$USER|g" {} +

# 3. Install System Dependencies
# Uses the provided pkglist.txt
if [ -f "pkglist.txt" ]; then
    echo -e "${BLUE}Installing packages from pkglist.txt using yay...${NC}"
    yay -S --needed --noconfirm $(cat pkglist.txt)
else
    echo -e "${RED}Error: pkglist.txt not found!${NC}"
    exit 1
fi

if [ -f "flatpak.txt" ]; then
    echo -e "${BLUE}Installing packages from flatpak.txt using flatpak...${NC}"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    cat installed_flatpaks.txt | xargs flatpak install -y
else
    echo -e "${RED}Error: flatpak.txt not found!${NC}"
    exit 1
fi

# 4. Install Python Dependencies for Pywal
# Required by README.md for haishoku and colorthief
echo -e "${BLUE}Installing Pywal backend dependencies...${NC}"
pip install haishoku colorthief --break-system-packages 2>/dev/null || pip install haishoku colorthief

# 5. Create necessary directory structure
echo -e "${BLUE}Creating directory structure...${NC}"
mkdir -p ~/.config

# 6. Copy everything to the Home directory
# This copies the .config folder and the Downloads folder
echo -e "${BLUE}Deploying configuration files and wallpapers...${NC}"
cp -rv .config ~/

# 1. Ask for the new username
read -p "Enter the new username to use in the path: " NEW_USER

# Define the search and replacement strings
SEARCH="/home/nekorosys/"
REPLACE="/home/$NEW_USER/"

echo "Searching for $SEARCH and replacing with $REPLACE..."
echo "----------------------------------------------------"

# 2. Find files and ask for confirmation on each match
find "$HOME/.config" -type f -print0 | while IFS= read -r -d '' file; do
    # Check if the file contains the string before bothering the user
    if grep -q "$SEARCH" "$file"; then
        echo ""
        echo "Found match in: $file"
        read -p "Apply replacement in this file? (y/n): " choice
        
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            # We use | as a sed delimiter to handle the slashes in the path
            sed -i "s|$SEARCH|$REPLACE|g" "$file"
            echo "✅ Updated: $file"
        else
            echo "⏭️  Skipped: $file"
        fi
    fi
done

echo "----------------------------------------------------"
echo "Process complete."

# 7. Set executable permissions for scripts
# Ensures wallpaper and lock scripts can run
echo -e "${BLUE}Setting script permissions...${NC}"
chmod +x ~/.config/hypr/scripts/*.sh 2>/dev/null
chmod +x ~/.config/hypr/scripts/wallpapers/*.sh 2>/dev/null
echo -e "${BLUE}Enabling waybar...${NC}"
sudo systemctl enable ~/.config/systemd/user/waybar.service
echo -e "${GREEN}Installation complete!${NC}"






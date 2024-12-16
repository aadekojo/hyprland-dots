#!/bin/bash

# Define variables
GREEN="$(tput setaf 2)[OK]$(tput sgr0)"
RED="$(tput setaf 1)[ERROR]$(tput sgr0)"
YELLOW="$(tput setaf 3)[NOTE]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
LOG="install.log"

# Set the script to exit on error
set -e

printf "$(tput setaf 2) Welcome to the Arch Linux Hyprland installer!\n $(tput sgr0)"

sleep 2

printf "$YELLOW PLEASE BACKUP YOUR FILES BEFORE PROCEEDING!
This script will overwrite some of your configs and files!"

sleep 2

printf "\n
$YELLOW  Some commands require you to enter your password inorder to execute
If you are worried about entering your password, you can cancel the script now with CTRL Q or CTRL C and review contents of this script. \n"

sleep 3

# Function to print error messages
print_error() {
    printf " %s%s\n" "$RED" "$1" "$NC" >&2
}

# Function to print success messages
print_success() {
    printf "%s%s%s\n" "$GREEN" "$1" "$NC"
}

### Install packages ####
read -n1 -rep "${CAT} Would you like to install the packages? (y/n)" inst
echo

if [[ $inst =~ ^[Nn]$ ]]; then
    printf "${YELLOW} No packages installed. Goodbye! \n"
            exit 1
        fi

if [[ $inst =~ ^[Yy]$ ]]; then
    #Offcial repository packages
   hypr_pkgs="hyprland wl-clipboard rofi-wayland sddm noto-fonts ttf-font-awesome xdg-desktop-portal-hyprland"
   app_pkgs="nwg-look qt6-wayland qt5-wayland qt5ct btop jq gvfs mpv playerctl vlc brightnessctl pamixer noise-suppression-for-voice"
   app_pkgs2="viewnior pavucontrol thunar tumbler thunar-archive-plugin thunar-volman xdg-user-dirs"
   #theme_pkgs=""

# AUR packages
   aur_pkgs="grimblast-git aylurs-gtk-shell-git hyprpolkitagent brave-bin"

# Ensure the script has sudo privileges
if ! sudo -v; then
    echo "Error: This script requires sudo privileges."
    exit 1
fi


# Install official packages
if ! sudo pacman -S --needed --noconfirm $hypr_pkgs $app_pkgs $app_pkgs2 2>&1 | tee -a $LOG; then
       print_error " Failed to install official packages - please check the install.log \n"
       exit 1
   fi

   echo
   echo "AUR packages need to be installed seperately: $aur_pkgs"
   sleep 1

# Check for yay or paru
    if command -v yay &> /dev/null; then
        aur_helper="yay"
    elif command -v paru &> /dev/null; then
        aur_helper="paru"
    else
        print_error "Neither yay nor paru found. Please install one of them to continue."
        exit 1
    fi

    if ! $aur_helper -S --noconfirm $aur_pkgs 2>&1 | tee -a $LOG; then
        print_error " Failed to install additional packages - please check the install.log \n"
        exit 1
    fi
    xdg-user-dirs-update
    echo
    print_success " All necessary packages installed successfully."

else
    echo
    print_error " Packages not installed - please check the install.log"
    sleep 1
fi

### Copy Config Files ###
read -n1 -rep "${CAT} Would you like to copy config files? (y,n)" CFG
if [[ $CFG =~ ^[Yy]$ ]]; then
    printf " Copying config files...\n"
    mkdir -p ~/.config/hypr
    mkdir -p ~/.config/kitty
    mkdir -p ~/.config/rofi
    cp -r hyprland-dots/.config/hypr ~/.config/ 2>&1 | tee -a $LOG
    cp -r hyprland-dots/.config/kitty ~/.config/ 2>&1 | tee -a $LOG
    cp -r hyprland-dots/.config/rofi ~/.config/ 2>&1 | tee -a $LOG

fi

FONT_DIR="$HOME/.local/share/fonts"
FONT_ZIP="$FONT_DIR/FiraCode.zip"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"

# Check if FiraCode Nerd-font is already installed
if fc-list | grep -qi "FiraCode"; then
    echo "FiraCode Nerd-fonts are already installed."
    exit 0
fi

echo "Installing FiraCode Nerd-fonts..."

# Download the font zip file if it doesn't already exist
if [ ! -f "$FONT_ZIP" ]; then
    wget -O "$FONT_ZIP" "$FONT_URL" || {
        echo "Failed to download FiraCode Nerd-fonts from $FONT_URL"
        exit 1
    }
else
    echo "FiraCode.zip already exists in $FONT_DIR, skipping download."
fi

if [ ! -d "$FONT_DIR/FiraCode" ]; then
    unzip -o "$FONT_ZIP" -d "$FONT_DIR" || {
        echo "Failed to unzip $FONT_ZIP"
        exit 1
    }
else
    echo "FiraCode font files already unzipped in $FONT_DIR, skipping unzip."
fi
rm "$FONT_ZIP"
fc-cache -fv # Rebuild the font cache
echo "FiraCode Nerd-fonts installed successfully"

# BLUETOOTH
read -n1 -rep "${CAT} OPTIONAL - Would you like to install Bluetooth packages? (y/n)" BLUETOOTH
if [[ $BLUETOOTH =~ ^[Yy]$ ]]; then
    printf " Installing Bluetooth Packages...\n"
 blue_pkgs="bluez bluez-utils blueman"
    if ! yay -S --noconfirm $blue_pkgs 2>&1 | tee -a $LOG; then
       	print_error "Failed to install bluetooth packages - please check the install.log"    
    printf " Activating Bluetooth Services...\n"
    sudo systemctl enable --now bluetooth.service
    sudo systemctl start bluetooth.service
    sleep 2
    fi
else
    printf "${YELLOW} No bluetooth packages installed..\n"
	fi

#PRINTER DRIVERS
read -n1 -rep "${CAT} OPTIONAL - Would you like to install Printer packages? (y/n)" PRINTER
if [[ $PRINTER =~ ^[Yy]$ ]]; then
    printf " Installing Printer Packages...\n"
    PKGS=(
    'cups'                  # Open source printer drivers
    'cups-pdf'              # PDF support for cups
    'ghostscript'           # PostScript interpreter
    'gsfonts'               # Adobe Postscript replacement fonts
    'hplip'                 # HP Drivers
    'system-config-printer' # Printer setup  utility
    )
    
    if ! sudo pacman -S "$PKG" --noconfirm --needed 2>&1 | tee -a $LOG; then
        print_error "Failed to install Printer packages - please check the install.log"   
    printf " Activating Printer Services...\n"
    systemctl enable org.cups.cupsd.service
    systemctl start org.cups.cupsd.service
    sleep 2
    fi
else
    printf "${YELLOW} No Printer packages installed..\n"
	fi



### Script is done ###
printf "\n${GREEN} Installation Completed.\n"
echo -e "${GREEN} You can start Hyprland by typing Hyprland (note the capital H).\n"
read -n1 -rep "${CAT} Would you like to start Hyprland now? (y,n)" HYP
if [[ $HYP =~ ^[Yy]$ ]]; then
    if command -v Hyprland >/dev/null; then
        exec Hyprland
    else
         print_error " Hyprland not found. Please make sure Hyprland is installed by checking install.log.\n"
        exit 1
    fi
else
    exit
fi







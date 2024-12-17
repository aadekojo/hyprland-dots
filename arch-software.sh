#!/bin/bash
#-------------------------------------------------------------------------------------
#     ___              __       _____       ______
#    /   |  __________/ /_     / ___/____  / __/ /__      ______ ______________
#   / /| | / ___/ ___/ __ \    \__ \/ __ \/ /_/ __/ | /| / / __ `/ ___/ ___/ _ \
#  / ___ |/ /  / /__/ / / /   ___/ / /_/ / __/ /_ | |/ |/ / /_/ / /  / /  /  __/
# /_/  |_/_/   \___/_/ /_/   /____/\____/_/  \__/ |__/|__/\__,_/_/  /_/   \___/
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------------------

echo
echo "INSTALLING SOFTWARE.........."
echo

PKGS=(
    # SYSTEM --------------------------------------------------------------

    # 'linux-lts'             # Long term support kernel

    # TERMINAL UTILITIES --------------------------------------------------
    'curl'                  # Remote content retrieval
    'fastfetch'             # Shows system info when you launch terminal
    'openssh'               # SSH connectivity tools
    'unzip'                 # Zip compression program
    'kitty'                 # Terminal Emulator

    # DISK UTILITIES ------------------------------------------------------
    'gparted'               # Disk utility

    # DEVELOPMENT ---------------------------------------------------------
    'clang'                 # C Lang compiler
    'cmake'                 # Cross-platform open-source make system
    'git'                   # Version control system
    'wget'

    # MEDIA ---------------------------------------------------------------
    'vlc'                   # Video player

    # PRODUCTIVITY --------------------------------------------------------
    'gwenview'              #image viewer
    'thunar'                #file explorer
    'thunar-archive-plugin' #thunar helper
    'thunar-volman'         #thunar helper

    #FONTS ----------------------------------------------------------------
    'ttf-font-awesome'      #font awesonme
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Installed Official Programs"
echo

echo
echo "INSTALLING AUR SOFTWARE"
echo

cd "${HOME}"
mkdir -p packages
git clone "https://aur.archlinux.org/yay.git"
cd yay
makepkg -si

printf " ---------------------------installed YAY--------------------\n "
echo "This is a test and nothing was installed after yay"

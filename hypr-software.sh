#!/bin/bash

# INSTALL PACKAGES
sudo pacman -S --noconfirm --needed hyprland
sudo pacman -S --noconfirm --needed xdg-desktop-portal-hyprland
sudo pacman -S --noconfirm --needed rofi-wayland
sudo pacman -S --noconfirm --needed kitty
#sudo pacman -S --noconfirm --needed xorg-xwayland

sudo pacman -S --noconfirm --needed ttf-font-awesome
#sudo pacman -S --noconfirm --needed waybar
#sudo pacman -S --noconfirm --needed wlogout
#sudo pacman -S --noconfirm --needed pamixer
sudo pacman -S --noconfirm --needed pavucontrol
sudo pacman -S --noconfirm --needed wl-clipboard
sudo pacman -S --noconfirm --needed brightnessctl
sudo pacman -S --noconfirm --needed pipewire
sudo pacman -S --noconfirm --needed libgtop
sudo pacman -S --noconfirm --needed bluez 
sudo pacman -S --noconfirm --needed bluez-utils
sudo pacman -S --noconfirm --needed mpv viewnior pavucontrol thunar tumbler thunar-archive-plugin thunar-volman xdg-user-dirs wget


sudo pacman -S --noconfirm --needed qt6-wayland qt5-wayland qt5ct btop jq gvfs mpv playerctl vlc brightnessctl pamixer noise-suppression-for-voice
sudo pacman -S --noconfirm --needed kvantum
sudo pacman -S --noconfirm --needed nwg-look

# MORE PACKAGES
sudo pacman -S --noconfirm --needed thunar
sudo pacman -S --noconfirm --needed thunar-archive-plugin
sudo pacman -S --noconfirm --needed thunar-volman
sudo pacman -S --noconfirm --needed vlc
sudo pacman -S --noconfirm --needed qbittorrent

sudo pacman -S --noconfirm --needed cantarell-fonts
# INSTALL PACKAGES WITH YAY
yay -S --noconfirm --needed grimblast-git
yay -S --noconfirm --needed qt6ct-kde
yay -S --noconfirm --needed hyprpolkitagent
yay -S --noconfirm --needed aylurs-gtk-shell-git
yay -S --noconfirm --needed brave-bin
#sudo pacman -S --noconfirm --needed hyprpaper
#sudo pacman -S --noconfirm --needed hyprlock
#sudo pacman -S --noconfirm --needed hypridle

echo "Done installing!................."

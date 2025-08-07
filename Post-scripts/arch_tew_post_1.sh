#!/bin/bash

set -e

cat << 'EOF' >> ~/.bashrc
alias cc='cat'
alias la='ls -la'
alias ll='ls -l'
alias lt='ls -lrt'
alias lz='ls -lZ'
alias lta='ls -lrta'
alias nn='nano'
alias py='python3'
alias rr='rm -rf'
alias tt='tail -f'
alias ttt='truncate -s0'
alias vv='vim'
alias errors='journalctl -p err -b'
alias update='yay -Syu --noconfirm'
alias clean='yay -Rns $(pacman -Qdtq) --noconfirm && sudo paccache -r -k3'
EOF
source ~/.bashrc
echo -e "\n░▒▓█ ALIASES AÑADIDOS. █▓▒░\n"

gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.peripherals.keyboard delay 200
#gsettings set org.gnome.desktop.background picture-uri "file://$HOME/wallpaper_kanagawa_color.png"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
#gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/wallpaper_kanagawa_bn.png"

if ! command -v yay &>/dev/null; then
    cd ~
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm --rmdeps
    echo -e "\n░▒▓█ 'yay' INSTALADO. █▓▒░\n"
    cd ..
    rm -rf yay
else
    echo -e "\n░▒▓█ 'yay' YA ESTÁ INSTALADO. █▓▒░\n"
fi

yay -Syu --noconfirm
echo -e "\n░▒▓█ 'yay' ACTUALIZADO. █▓▒░\n"

yay -S --noconfirm --needed gdm-settings gnome-shell-extension-installer
echo -e "\n░▒▓█ INSTALADO 'gdm-settings'. █▓▒░\n."
echo -e "\n░▒▓█ INSTALADO 'gnome-shell-extension-installer'. █▓▒░\n"

gnome-shell-extension-installer 307 3210 4269 5219 7502 7535 --yes

echo -e "\n░▒▓█ INSTALADO 'Dash to Dock'. █▓▒░\n"
echo -e "\n░▒▓█ INSTALADO 'Compiz windows effect'. █▓▒░\n"
echo -e "\n░▒▓█ INSTALADO 'Alphabetical App Grid'. █▓▒░\n"
echo -e "\n░▒▓█ INSTALADO 'TopHat'. █▓▒░\n"
echo -e "\n░▒▓█ INSTALADO 'Auto Accent Colour'. █▓▒░\n"
echo -e "\n░▒▓█ INSTALADO 'Accent Icons'. █▓▒░\n"

sudo pacman -Rns $(pacman -Qdtq)

sudo reboot now
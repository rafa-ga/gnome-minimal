#!/bin/bash

set -e

cat << 'EOF' >> "$HOME/.bashrc"
alias cc='cat'
alias clean='yay -Rns $(pacman -Qdtq) --noconfirm && sudo paccache -r -k3'
alias errors='journalctl -p err -b'
alias la='ls -la'
alias ll='ls -l'
alias lt='ls -lrt'
alias lz='ls -lZ'
alias lta='ls -lrta'
alias nn='nano'
alias py='python3'
alias rr='rm -rf'
alias software='echo -e "\n░▒▓█ PAQUETES PACMAN: █▓▒░\n" && pacman -Qn && echo -e "\n░▒▓█ PAQUETES AUR: █▓▒░\n" && pacman -Qm && echo -e "\n░▒▓█ PAQUETES FLATPAK: █▓▒░\n" && flatpak list'
alias tt='tail -f'
alias ttt='truncate -s0'
alias vv='vim'
alias update='yay -Syu --noconfirm'
EOF
source "$HOME/.bashrc"
echo -e "\n░▒▓█ ALIASES AÑADIDOS. █▓▒░\n"
sleep 3

gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.peripherals.keyboard delay 250

if ! command -v yay &>/dev/null; then
    cd "$HOME"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm --rmdeps
    echo -e "\n░▒▓█ 'yay' INSTALADO. █▓▒░\n"
    sleep 3
    cd ..
    rm -rf yay
else
    echo -e "\n░▒▓█ 'yay' YA ESTÁ INSTALADO. █▓▒░\n"
    sleep 3
fi

yay -Syu --noconfirm
echo -e "\n░▒▓█ 'yay' ACTUALIZADO. █▓▒░\n"
sleep 3

yay -S --noconfirm --needed gdm-settings gnome-shell-extension-installer
echo -e "\n░▒▓█ INSTALADO 'gdm-settings'. █▓▒░\n"
echo -e "\n░▒▓█ INSTALADO 'gnome-shell-extension-installer'. █▓▒░\n"
sleep 3

gnome-shell-extension-installer 307 3210 4269 5219 7065 7535 --yes

echo -e "\n░▒▓█ INSTALADO 'Dash to Dock'. █▓▒░\n"
echo -e "\n░▒▓█ INSTALADO 'Compiz windows effect'. █▓▒░\n"
echo -e "\n░▒▓█ INSTALADO 'Alphabetical App Grid'. █▓▒░\n"
echo -e "\n░▒▓█ INSTALADO 'TopHat'. █▓▒░\n"
echo -e "\n░▒▓█ INSTALADO 'Tiling Shell'. █▓▒░\n"
echo -e "\n░▒▓█ INSTALADO 'Accent Icons'. █▓▒░\n"
sleep 3

sudo pacman -Rns --noconfirm $(pacman -Qdtq)
echo -e "\n░▒▓█ DEPENDENCIAS HUÉRFANAS ELIMINADAS. █▓▒░\n"

echo -e "\n░▒▓█ REINICIANDO EN 3... █▓▒░\n"
sleep 1
echo -e "\n░▒▓█ REINICIANDO EN 2... █▓▒░\n"
sleep 1
echo -e "\n░▒▓█ REINICIANDO EN 1... █▓▒░\n"
sleep 1
sudo reboot now

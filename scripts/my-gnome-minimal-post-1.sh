#!/bin/bash

set -e

echo -e "\n░▒▓█ INICIANDO SEGUNDA FASE. █▓▒░\n"; sleep 1

truncate -s0 "$HOME/.bashrc"
cat << 'EOF' >> "$HOME/.bashrc"
alias cc='cat'
alias clean='pacman -Qdtq | xargs -r yay -Rns --noconfirm && sudo paccache -r -k3'
alias errors='journalctl -p err -b'
alias la='ls -la'
alias ll='ls -l'
alias lt='ls -lrt'
alias lz='ls -lZ'
alias lta='ls -lrta'
alias nn='nano'
alias py='python3'
alias rr='rm -rf'
alias software='echo -e "\n░▒▓█ PAQUETES PACMAN: █▓▒░\n" && pacman -Qne && echo -e "\n░▒▓█ PAQUETES AUR: █▓▒░\n" && pacman -Qm && echo -e "\n░▒▓█ PAQUETES FLATPAK: █▓▒░\n" && flatpak list'
alias tt='tail -f'
alias ttt='truncate -s0'
alias vv='vim'
alias update='yay -Syu --noconfirm'
PS1="\[\e[38;5;255m\]\u\[\e[0m\]@\[\e[38;5;255m\]\w\[\e[0m\] » "
EOF
source "$HOME/.bashrc"
echo -e "░▒▓█ ALIASES AÑADIDOS. █▓▒░\n"; sleep 1

mkdir "$HOME/.icons"
tar -xf "/opt/gnome-minimal/iconos/Reversal.tar.xz" -C "$HOME/.icons"
rm -rf "/opt/gnome-minimal/iconos"

gsettings set org.gnome.desktop.interface icon-theme Reversal; sleep 1
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'; sleep 1
gsettings set org.gnome.desktop.peripherals.keyboard delay 250; sleep 1

if ! command -v yay &>/dev/null; then
    cd "$HOME"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm --rmdeps
    echo -e "\n░▒▓█ 'yay' INSTALADO. █▓▒░\n"
    cd ..
    rm -rf yay
else
    echo -e "\n░▒▓█ 'yay' YA ESTÁ INSTALADO. █▓▒░\n"
fi
sleep 1

yay -Syu --noconfirm
echo -e "\n░▒▓█ REPOSITORIO 'AUR' ACTUALIZADO. █▓▒░\n"; sleep 1

yay -S --noconfirm --needed gapless gdm-settings gnome-shell-extension-installer
echo -e "\n░▒▓█ INSTALADO 'gapless'. █▓▒░"
echo -e "\n░▒▓█ INSTALADO 'gdm-settings'. █▓▒░"
echo -e "\n░▒▓█ INSTALADO 'gnome-shell-extension-installer'. █▓▒░\n"; sleep 1

gnome-shell-extension-installer 307 3210 4269 5219 7065 --yes

echo -e "\n░▒▓█ INSTALADO 'Dash to Dock'. █▓▒░"
echo -e "\n░▒▓█ INSTALADO 'Compiz windows effect'. █▓▒░"
echo -e "\n░▒▓█ INSTALADO 'Alphabetical App Grid'. █▓▒░"
echo -e "\n░▒▓█ INSTALADO 'TopHat'. █▓▒░"
echo -e "\n░▒▓█ INSTALADO 'Tiling Shell'. █▓▒░\n"; sleep 1

yay -Rns --noconfirm gnome-shell-extension-installer
echo -e "\n░▒▓█ DESINSTALADO 'gnome-shell-extension-installer'. █▓▒░\n"

pacman -Qdtq | xargs -r yay -Rns --noconfirm
echo -e "\n░▒▓█ DEPENDENCIAS HUÉRFANAS ELIMINADAS. █▓▒░"

touch "$HOME/.config/.my-gnome_minimal_post_1_done"

rm -f "$HOME/.config/systemd/user/my-gnome-minimal-post-1.service"
echo -e "\n░▒▓█ SERVICIO POST-INSTALACIÓN 1 ELIMINADO. █▓▒░\n"; sleep 1

mv "/opt/gnome-minimal/configuracion/my-gnome-minimal-post-2.service" "$HOME/.config/systemd/user"
ln -sf "$HOME/.config/systemd/user/my-gnome-minimal-post-2.service" "$HOME/.config/systemd/user/graphical-session.target.wants/my-gnome-minimal-post-2.service"
echo -e "░▒▓█ DAEMON POST-INSTALACIÓN 2 CREADO EN '$HOME/.config/systemd/user'. █▓▒░\n"; sleep 1

echo -e "░▒▓█ EL SISTEMA SE REINICIARÁ (2/3) EN: █▓▒░\n"; sleep 1
echo -e "3...\n"; sleep 1
echo -e "2...\n"; sleep 1
echo -e "1...\n"; sleep 1
systemctl reboot

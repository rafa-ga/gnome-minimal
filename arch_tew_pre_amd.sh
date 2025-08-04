#!/bin/bash

set -e

pacman -Syu --noconfirm
echo -e "\nSISTEMA ACTUALIZADO.\n"

pacman -S --noconfirm --needed \
amd-ucode \
awesome-terminal-fonts \
baobab \
base-devel \
bluez \
bluez-utils \
curl \
evince \
file-roller \
flatpak \
gdm \
git \
glib2 \
gnome-browser-connector \
gnome-calculator \
gnome-characters \
gnome-color-manager \
gnome-control-center \
gnome-disk-utility \
gnome-font-viewer \
gnome-keyring \
gnome-logs \
gnome-menus \
gnome-session \
gnome-settings-daemon \
gnome-shell \
gnome-shell-extensions \
gnome-software \
gnome-terminal \
gnome-text-editor \
gvfs \
gvfs-nfs \
gvfs-smb \
less \
loupe \
mission-center \
nano \
nautilus \
networkmanager \
pipewire \
pipewire-audio \
pipewire-jack \
pipewire-pulse \
power-profiles-daemon \
sushi \
tar \
timeshift \
ttf-dejavu \
ttf-fira-code \
ttf-roboto \
unrar \
vim \
vlc \
wget \
wireplumber \
xdg-desktop-portal \
xdg-desktop-portal-gnome \
xorg-xwayland
echo -e "\nPAQUETES BÁSICOS INSTALADOS.\n"

systemctl start NetworkManager && systemctl enable NetworkManager
echo -e "\n'NetworkManager' HABILITADO E INICIADO.\n"

systemctl start bluetooth && systemctl enable bluetooth
echo -e "\nBLUETOOTH HABILITADO E INICIADO.\n"

systemctl enable gdm
echo -e "\n'gdm' HABILITADO.\n"

if ! grep -qx '\[multilib\]' /etc/pacman.conf; then
    echo -e '\n[multilib]' >> /etc/pacman.conf
    echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
    sync
    pacman -Syu --noconfirm
    echo -e "\nREPOSITORIO 'multilib' HABILITADO Y ACTUALIZADO.\n"
else
    pacman -Syu --noconfirm
    echo -e "\nREPOSITORIO 'multilib' ACTUALIZADO.\n"
fi

pacman -S --noconfirm --needed \
mesa lib32-mesa \
vulkan-radeon lib32-vulkan-radeon \
gamemode lib32-gamemode \
mangohud lib32-mangohud \
xf86-video-amdgpu
echo -e "\nPAQUETES GAMING INSTALADOS.\n"

echo 'NoDisplay=true' >> /usr/share/applications/avahi-discover.desktop
echo 'NoDisplay=true' >> /usr/share/applications/bssh.desktop
echo 'NoDisplay=true' >> /usr/share/applications/bvnc.desktop
echo 'NoDisplay=true' >> /usr/share/applications/nvtop.desktop
echo 'NoDisplay=true' >> /usr/share/applications/qv4l2.desktop
echo 'NoDisplay=true' >> /usr/share/applications/qvidcap.desktop
echo 'NoDisplay=true' >> /usr/share/applications/vim.desktop
echo 'NoDisplay=true' >> /usr/share/applications/vlc.desktop
echo -e "\nAPLICACIONES OCULTADAS.\n"

rm -rf /usr/share/gnome-shell/extensions/apps-menu@gnome-shell-extensions.gcampax.github.com
rm -rf /usr/share/gnome-shell/extensions/auto-move-windows@gnome-shell-extensions.gcampax.github.com
rm -rf /usr/share/gnome-shell/extensions/drive-menu@gnome-shell-extensions.gcampax.github.com
rm -rf /usr/share/gnome-shell/extensions/launch-new-instance@gnome-shell-extensions.gcampax.github.com
rm -rf /usr/share/gnome-shell/extensions/light-style@gnome-shell-extensions.gcampax.github.com
rm -rf /usr/share/gnome-shell/extensions/native-window-placement@gnome-shell-extensions.gcampax.github.com
rm -rf /usr/share/gnome-shell/extensions/places-menu@gnome-shell-extensions.gcampax.github.com
rm -rf /usr/share/gnome-shell/extensions/screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com
rm -rf /usr/share/gnome-shell/extensions/status-icons@gnome-shell-extensions.gcampax.github.com
rm -rf /usr/share/gnome-shell/extensions/system-monitor@gnome-shell-extensions.gcampax.github.com
rm -rf /usr/share/gnome-shell/extensions/window-list@gnome-shell-extensions.gcampax.github.com
rm -rf /usr/share/gnome-shell/extensions/windowsNavigator@gnome-shell-extensions.gcampax.github.com
rm -rf /usr/share/gnome-shell/extensions/workspace-indicator@gnome-shell-extensions.gcampax.github.com
echo -e "\nEXTENSIONES LEGACY ELIMINADAS.\n"

sudo sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=3/' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
echo -e "\nGRUB CONFIGURADO A 3 SEGUNDOS.\n"

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo -e "\nREPOSITORIO 'FlatHub' AÑADIDO.\n"

flatpak update -y
echo -e "\n'Flatpak' ACTUALIZADO.\n"

sleep 5
reboot now
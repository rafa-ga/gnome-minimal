#!/bin/bash

set -e

pacman -Syu --noconfirm
echo -e "\n░▒▓█ SISTEMA ACTUALIZADO. █▓▒░\n"

model=$(lscpu | grep -iE "Model name|Nombre del modelo" | awk -F: '{print $2}' | sed 's/^ *//')

if [[ "$model" =~ QEMU || "$model" =~ KVM || "$model" =~ VirtualBox || "$model" =~ VMware || "$model" =~ Microsoft || "$model" =~ Hyper-V ]]; then
    echo -e "\n░▒▓█ DETECTADA MÁQUINA VIRTUAL. █▓▒░\n"
elif [[ "$model" =~ Intel ]]; then
    pacman -S --noconfirm --needed intel-ucode
    echo -e "\n░▒▓█ DETECTADA CPU INTEL. █▓▒░\n"
elif [[ "$model" =~ AMD ]]; then
    pacman -S --noconfirm --needed amd-ucode
    echo -e "\n░▒▓█ DETECTADA CPU AMD. █▓▒░\n"
else
    echo -e "\n░▒▓█ CPU NO RECONOCIDA: $model █▓▒░\n"
fi

pacman -S --noconfirm --needed \
awesome-terminal-fonts \
baobab \
base-devel \
bluez \
bluez-utils \
curl \
evince \
ffmpeg \
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
os-prober \
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
vlc-plugins-all \
wget \
wireplumber \
xdg-desktop-portal \
xdg-desktop-portal-gnome \
xorg-xwayland
echo -e "\n░▒▓█ PAQUETES BÁSICOS INSTALADOS. █▓▒░\n"

systemctl start NetworkManager && systemctl enable NetworkManager
echo -e "\n░▒▓█ 'NetworkManager' HABILITADO E INICIADO. █▓▒░\n"

systemctl start bluetooth && systemctl enable bluetooth
echo -e "\n░▒▓█ BLUETOOTH HABILITADO E INICIADO. █▓▒░\n"

systemctl enable gdm
echo -e "\n░▒▓█ 'gdm' HABILITADO. █▓▒░\n"

if ! grep -qx '\[multilib\]' /etc/pacman.conf; then
    echo -e '\n[multilib]' >> /etc/pacman.conf
    echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
    sync
    pacman -Syu --noconfirm
    echo -e "\n░▒▓█ REPOSITORIO 'multilib' HABILITADO Y ACTUALIZADO. █▓▒░\n"
else
    pacman -Syu --noconfirm
    echo -e "\n░▒▓█ REPOSITORIO 'multilib' ACTUALIZADO. █▓▒░\n"
fi

if [[ "$model" =~ QEMU || "$model" =~ KVM || "$model" =~ VirtualBox || "$model" =~ VMware || "$model" =~ Microsoft || "$model" =~ Hyper-V ]]; then
    echo -e "\n░▒▓█ NO SE INSTALARÁ NINGÚN PAQUETE PARA GAMING. █▓▒░\n"
elif [[ "$model" =~ Intel ]]; then
    pacman -S --noconfirm --needed mesa lib32-mesa vulkan-intel lib32-vulkan-intel gamemode lib32-gamemode
    echo -e "\n░▒▓█ PAQUETES GAMING INSTALADOS. █▓▒░\n"
elif [[ "$model" =~ AMD ]]; then
    pacman -S --noconfirm --needed mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon gamemode lib32-gamemode mangohud lib32-mangohud xf86-video-amdgpu
    echo -e "\n░▒▓█ PAQUETES GAMING INSTALADOS. █▓▒░\n"
else
    echo -e "\n░▒▓█ CPU NO RECONOCIDA: $model █▓▒░\n"
fi

echo 'NoDisplay=true' >> /usr/share/applications/avahi-discover.desktop
echo 'NoDisplay=true' >> /usr/share/applications/bssh.desktop
echo 'NoDisplay=true' >> /usr/share/applications/bvnc.desktop
echo 'NoDisplay=true' >> /usr/share/applications/nvtop.desktop
echo 'NoDisplay=true' >> /usr/share/applications/org.gnome.FileRoller.desktop
echo 'NoDisplay=true' >> /usr/share/applications/qv4l2.desktop
echo 'NoDisplay=true' >> /usr/share/applications/qvidcap.desktop
echo 'NoDisplay=true' >> /usr/share/applications/vim.desktop
echo 'NoDisplay=true' >> /usr/share/applications/vlc.desktop
echo -e "\n░▒▓█ APLICACIONES OCULTADAS. █▓▒░\n"

#rm -rf /usr/share/gnome-shell/extensions/apps-menu@gnome-shell-extensions.gcampax.github.com
#rm -rf /usr/share/gnome-shell/extensions/auto-move-windows@gnome-shell-extensions.gcampax.github.com
#rm -rf /usr/share/gnome-shell/extensions/drive-menu@gnome-shell-extensions.gcampax.github.com
#rm -rf /usr/share/gnome-shell/extensions/launch-new-instance@gnome-shell-extensions.gcampax.github.com
#rm -rf /usr/share/gnome-shell/extensions/light-style@gnome-shell-extensions.gcampax.github.com
#rm -rf /usr/share/gnome-shell/extensions/native-window-placement@gnome-shell-extensions.gcampax.github.com
#rm -rf /usr/share/gnome-shell/extensions/places-menu@gnome-shell-extensions.gcampax.github.com
#rm -rf /usr/share/gnome-shell/extensions/screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com
#rm -rf /usr/share/gnome-shell/extensions/status-icons@gnome-shell-extensions.gcampax.github.com
#rm -rf /usr/share/gnome-shell/extensions/system-monitor@gnome-shell-extensions.gcampax.github.com
#rm -rf /usr/share/gnome-shell/extensions/window-list@gnome-shell-extensions.gcampax.github.com
#rm -rf /usr/share/gnome-shell/extensions/windowsNavigator@gnome-shell-extensions.gcampax.github.com
#rm -rf /usr/share/gnome-shell/extensions/workspace-indicator@gnome-shell-extensions.gcampax.github.com
#echo -e "\n░▒▓█ EXTENSIONES LEGACY ELIMINADAS. █▓▒░\n"

sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=3/' /etc/default/grub
sed -i 's/^#\(GRUB_DISABLE_OS_PROBER=false\)/\1/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "\n░▒▓█ GRUB CONFIGURADO. █▓▒░\n"

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo -e "\n░▒▓█ REPOSITORIO 'FlatHub' AÑADIDO. █▓▒░\n"

flatpak update -y
echo -e "\n░▒▓█ 'Flatpak' ACTUALIZADO. █▓▒░\n"

sleep 5
reboot now
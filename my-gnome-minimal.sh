#!/bin/bash

set -e

echo -e "\n░▒▓█ INICIANDO PRIMERA FASE. █▓▒░\n"; sleep 1

pacman -Syu --noconfirm
echo -e "\n░▒▓█ SISTEMA ACTUALIZADO. █▓▒░\n"; sleep 1

model=$(lscpu | grep -iE "Model name|Nombre del modelo" | awk -F: '{print $2}' | sed 's/^ *//')

if [[ "$model" =~ QEMU || "$model" =~ KVM || "$model" =~ VirtualBox || "$model" =~ VMware || "$model" =~ Microsoft || "$model" =~ Hyper-V ]]; then
    echo -e "░▒▓█ DETECTADA MÁQUINA VIRTUAL. █▓▒░\n"
elif [[ "$model" =~ Intel ]]; then
    pacman -S --noconfirm --needed intel-ucode
    echo -e "\n░▒▓█ DETECTADA CPU INTEL. █▓▒░\n"
elif [[ "$model" =~ AMD ]]; then
    pacman -S --noconfirm --needed amd-ucode
    echo -e "\n░▒▓█ DETECTADA CPU AMD. █▓▒░\n"
else
    echo -e "░▒▓█ CPU NO RECONOCIDA: $model █▓▒░\n"
fi
sleep 1

pacman -S --noconfirm --needed \
baobab \
base-devel \
bluez \
bluez-utils \
cifs-utils \
curl \
dkms \
efibootmgr \
evince \
fastfetch \
ffmpeg \
ffmpegthumbnailer \
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
gnome-epub-thumbnailer \
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
gst-libav \
gvfs \
gvfs-nfs \
gvfs-smb \
gvfs-wsdd \
less \
libheif \
linux-zen-headers \
loupe \
man-db \
mission-center \
nano \
nautilus \
networkmanager \
nfs-utils \
ntfs-3g \
os-prober \
pacman-contrib \
pipewire \
pipewire-audio \
pipewire-jack \
pipewire-pulse \
power-profiles-daemon \
qt5-base \
qt6-base \
sushi \
tar \
timeshift \
unrar \
vi \
vim \
vlc \
vlc-plugins-all \
webp-pixbuf-loader \
wget \
wireplumber \
xdg-desktop-portal \
xdg-desktop-portal-gnome \
xorg-xwayland
echo -e "\n░▒▓█ PAQUETES BÁSICOS INSTALADOS. █▓▒░\n"; sleep 1

systemctl start NetworkManager && systemctl enable NetworkManager
echo -e "\n░▒▓█ 'NetworkManager' HABILITADO E INICIADO. █▓▒░\n"; sleep 1

systemctl start bluetooth && systemctl enable bluetooth
echo -e "\n░▒▓█ BLUETOOTH HABILITADO E INICIADO. █▓▒░\n"; sleep 1

systemctl enable gdm
echo -e "\n░▒▓█ 'gdm' HABILITADO. █▓▒░\n"; sleep 1

if ! grep -qx '\[multilib\]' /etc/pacman.conf; then
    echo -e '\n[multilib]' >> /etc/pacman.conf
    echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
    echo -e "░▒▓█ REPOSITORIO 'multilib' HABILITADO. █▓▒░\n"; sleep 3
    pacman -Sy --noconfirm
    echo -e "\n░▒▓█ REPOSITORIO 'multilib' ACTUALIZADO. █▓▒░\n"
else
    pacman -Sy --noconfirm
    echo -e "\n░▒▓█ REPOSITORIO 'multilib' ACTUALIZADO. █▓▒░\n"
fi

if [[ "$model" =~ QEMU || "$model" =~ KVM || "$model" =~ VirtualBox || "$model" =~ VMware || "$model" =~ Microsoft || "$model" =~ Hyper-V ]]; then
    echo -e "░▒▓█ NO SE INSTALARÁ NINGÚN PAQUETE PARA GAMING. █▓▒░\n"
elif [[ "$model" =~ Intel ]]; then
    pacman -S --noconfirm --needed mesa lib32-mesa vulkan-intel lib32-vulkan-intel gamemode lib32-gamemode
    echo -e "\n░▒▓█ PAQUETES GAMING INSTALADOS. █▓▒░\n"
elif [[ "$model" =~ AMD ]]; then
    pacman -S --noconfirm --needed mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon gamemode lib32-gamemode mangohud lib32-mangohud xf86-video-amdgpu
    echo -e "\n░▒▓█ PAQUETES GAMING INSTALADOS. █▓▒░\n"
else
    echo -e "░▒▓█ CPU NO RECONOCIDA: $model █▓▒░\n"
fi
sleep 1

for file in \
  /usr/share/applications/avahi-discover.desktop \
  /usr/share/applications/bssh.desktop \
  /usr/share/applications/bvnc.desktop \
  /usr/share/applications/nvtop.desktop \
  /usr/share/applications/org.gnome.FileRoller.desktop \
  /usr/share/applications/qv4l2.desktop \
  /usr/share/applications/qvidcap.desktop \
  /usr/share/applications/vim.desktop
do
  if [[ -f "$file" ]] && ! grep -Fxq "NoDisplay=true" "$file"; then
    echo 'NoDisplay=true' >> "$file"
    echo -e "░▒▓█ OCULTADA '$(basename "$file")'. █▓▒░\n"
  else
    echo -e "░▒▓█ '$(basename "$file")' YA ESTÁ OCULTA. █▓▒░\n"
  fi
done
sleep 1

rm -rf /usr/share/gnome-shell/extensions/*
echo -e "░▒▓█ EXTENSIONES LEGACY ELIMINADAS. █▓▒░\n"; sleep 1

sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=3/' /etc/default/grub
sed -i 's/^#\?GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "\n░▒▓█ GRUB CONFIGURADO. █▓▒░"; sleep 1

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo -e "░▒▓█ REPOSITORIO 'FlatHub' AÑADIDO. █▓▒░"; sleep 1

flatpak update -y
echo -e "\n░▒▓█ 'Flatpak' ACTUALIZADO. █▓▒░\n"; sleep 1

flatpak install -y flatseal
echo -e "\n░▒▓█ 'Flatseal' INSTALADO. █▓▒░\n"; sleep 1

HUMAN=$(getent passwd 1000 | cut -d: -f1)
git clone https://github.com/rafa-ga/gnome-minimal.git "/opt/gnome-minimal"
chown -R "$HUMAN":"$HUMAN" "/opt/gnome-minimal"
chmod +x /opt/gnome-minimal/scripts/*
echo -e "\n░▒▓█ REPOSITORIO DE GIT CLONADO EN '/opt/gnome-minimal'. █▓▒░\n"; sleep 1

HUMAN_HOME=$(getent passwd "$HUMAN" | cut -d: -f6)
mkdir -p "$HUMAN_HOME/.config/systemd/user/graphical-session.target.wants"
mv "/opt/gnome-minimal/configuracion/my-gnome-minimal-post-1.service" "$HUMAN_HOME/.config/systemd/user"
ln -sf "$HUMAN_HOME/.config/systemd/user/my-gnome-minimal-post-1.service" "$HUMAN_HOME/.config/systemd/user/graphical-session.target.wants/my-gnome-minimal-post-1.service"
chown -R "$HUMAN":"$HUMAN" "$HUMAN_HOME/.config/systemd/user/graphical-session.target.wants"
echo -e "░▒▓█ DAEMON POST-INSTALACIÓN 1 CREADO EN '$HUMAN_HOME/.config/systemd/user'. █▓▒░\n"; sleep 1

mkdir -p "$HUMAN_HOME/.local/share/backgrounds"
mv /opt/gnome-minimal/imagenes/wallpaper* "$HUMAN_HOME/.local/share/backgrounds"
chown -R "$HUMAN":"$HUMAN" "$HUMAN_HOME/.local/share"
rm -f /usr/share/pixmaps/faces/*
mv /opt/gnome-minimal/imagenes/avatar* "/usr/share/pixmaps/faces"
mv "/opt/gnome-minimal/imagenes/placeholder" "/var/lib/AccountsService/icons/$HUMAN"
chown -R "$HUMAN":"$HUMAN" "/var/lib/AccountsService/icons/$HUMAN"
rm -rf "/opt/gnome-minimal/imagenes" "/opt/gnome-minimal/.git"
echo -e "░▒▓█ AVATARES Y WALLPAPERS AÑADIDOS. █▓▒░\n"; sleep 1

tee /etc/gdm/custom.conf > /dev/null <<EOF
[daemon]
AutomaticLoginEnable=true
AutomaticLogin=$HUMAN
WaylandEnable=true
[security]
[xdmcp]
[chooser]
[debug]
#Enable=true
EOF
echo -e "░▒▓█ LOGIN AUTOMÁTICO PARA '$HUMAN' ACTIVADO. █▓▒░\n"; sleep 1

echo "$HUMAN ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

echo -e "░▒▓█ EL SISTEMA SE REINICIARÁ (1/3) EN: █▓▒░\n"; sleep 1
echo -e "3...\n"; sleep 1
echo -e "2...\n"; sleep 1
echo -e "1...\n"; sleep 1
reboot now

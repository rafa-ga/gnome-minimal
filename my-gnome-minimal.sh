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
avahi \
baobab \
base-devel \
bind \
bluez \
bluez-libs \
bluez-utils \
cifs-utils \
curl \
diffutils \
dkms \
efibootmgr \
evince \
fastfetch \
ffmpeg \
ffmpegthumbnailer \
file-roller \
findutils \
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
gnome-terminal \
gnome-text-editor \
grilo-plugins \
gst-libav \
gvfs \
gvfs-afc \
gvfs-dnssd \
gvfs-goa \
gvfs-google \
gvfs-mtp \
gvfs-nfs \
gvfs-onedrive \
gvfs-smb \
gvfs-wsdd \
hunspell-es_es \
inetutils \
less \
libcamera \
libheif \
libwnck3 \
linux-zen \
linux-zen-headers \
loupe \
man-db \
mesa-utils \
mission-center \
nano \
nautilus \
networkmanager \
nfs-utils \
ntfs-3g \
nss-mdns \
openssh \
pacman-contrib \
pipewire \
pipewire-audio \
pipewire-jack \
pipewire-pulse \
power-profiles-daemon \
qt5-base \
qt6-base \
smartmontools \
sushi \
tar \
timeshift \
unrar \
unzip \
util-linux \
vi \
vim \
vlc \
vlc-plugins-all \
webp-pixbuf-loader \
wget \
wireplumber \
xdg-desktop-portal \
xdg-desktop-portal-gnome \
xdg-user-dirs-gtk \
xdg-utils \
xorg-xwayland \
xz
echo -e "\n░▒▓█ PAQUETES BÁSICOS INSTALADOS. █▓▒░\n"; sleep 1

systemctl start bluetooth && systemctl enable bluetooth
echo -e "\n░▒▓█ BLUETOOTH HABILITADO E INICIADO. █▓▒░\n"; sleep 1

systemctl enable gdm
echo -e "\n░▒▓█ 'gdm' HABILITADO. █▓▒░\n"; sleep 1

if [[ "$model" =~ QEMU || "$model" =~ KVM || "$model" =~ VirtualBox || "$model" =~ VMware || "$model" =~ Microsoft || "$model" =~ Hyper-V ]]; then
    echo -e "░▒▓█ NO SE INSTALARÁ NINGÚN PAQUETE PARA GAMING. █▓▒░\n"
elif [[ "$model" =~ Intel ]]; then
    pacman -S --noconfirm --needed mesa lib32-mesa vulkan-intel lib32-vulkan-intel gamemode lib32-gamemode intel-media-driver libva-intel-driver sof-firmware
    echo -e "\n░▒▓█ PAQUETES GAMING INSTALADOS. █▓▒░\n"
elif [[ "$model" =~ AMD ]]; then
    pacman -S --noconfirm --needed mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon gamemode lib32-gamemode mangohud lib32-mangohud xf86-video-amdgpu libva-mesa-driver
    echo -e "\n░▒▓█ PAQUETES GAMING INSTALADOS. █▓▒░\n"
else
    echo -e "░▒▓█ CPU NO RECONOCIDA: $model █▓▒░\n"
fi
sleep 1

if ls /boot/loader/entries/*linux.conf >/dev/null 2>&1; then
    sed -i 's/^title.*/title Arch/' /boot/loader/entries/*linux.conf
    sed -i '/^options/ s/$/ quiet loglevel=3 systemd.show_status=1 rd.systemd.show_status=1/' /boot/loader/entries/*linux.conf
    echo "sort-key 10-arch" >> /boot/loader/entries/*linux.conf
fi

if ls /boot/loader/entries/*linux-zen.conf >/dev/null 2>&1; then
    sed -i 's/^title.*/title Arch Zen/' /boot/loader/entries/*linux-zen.conf
    sed -i '/^options/ s/$/ quiet loglevel=3 systemd.show_status=1 rd.systemd.show_status=1/' /boot/loader/entries/*linux-zen.conf
    echo "sort-key 20-arch_zen" >> /boot/loader/entries/*linux-zen.conf
fi

if ls /boot/loader/entries/*linux-fallback.conf >/dev/null 2>&1; then
    sed -i 's/^title.*/title Arch (fallback)/' /boot/loader/entries/*linux-fallback.conf
    echo "sort-key 30-arch" >> /boot/loader/entries/*linux-fallback.conf
fi

if ls /boot/loader/entries/*linux-zen-fallback.conf >/dev/null 2>&1; then
    sed -i 's/^title.*/title Arch Zen (fallback)/' /boot/loader/entries/*linux-zen-fallback.conf
    echo "sort-key 40-arch_zen" >> /boot/loader/entries/*linux-zen-fallback.conf
fi

tee /boot/loader/loader.conf > /dev/null <<'EOF'
default @saved
timeout 3
console-mode auto
editor no
auto-firmware no
EOF
echo -e "░▒▓█ CONFIGURADO 'systemd-boot'. █▓▒░\n"

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
chown -R "$HUMAN":"$HUMAN" "/var/lib/AccountsService/icons"
rm -rf "/opt/gnome-minimal/imagenes" "/opt/gnome-minimal/.git"
echo -e "░▒▓█ AVATARES Y WALLPAPERS AÑADIDOS. █▓▒░\n"; sleep 1

mkdir -p /home/$HUMAN/.local/state/wireplumber
mkdir -p /home/$HUMAN/.local/state/Heroic
chown $HUMAN:$HUMAN -R /home/$HUMAN/.local/state
chmod 755 -R /home/$HUMAN/.local/state

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

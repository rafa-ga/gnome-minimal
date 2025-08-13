#!/bin/bash

set -e

pacman -Syu --noconfirm
echo -e "\n░▒▓█ SISTEMA ACTUALIZADO. █▓▒░\n"; sleep 3

model=$(lscpu | grep -iE "Model name|Nombre del modelo" | awk -F: '{print $2}' | sed 's/^ *//')

if [[ "$model" =~ QEMU || "$model" =~ KVM || "$model" =~ VirtualBox || "$model" =~ VMware || "$model" =~ Microsoft || "$model" =~ Hyper-V ]]; then
    echo -e "░▒▓█ DETECTADA MÁQUINA VIRTUAL. █▓▒░\n"
elif [[ "$model" =~ Intel ]]; then
    pacman -S --noconfirm --needed intel-ucode
    echo -e "░▒▓█ DETECTADA CPU INTEL. █▓▒░\n"
elif [[ "$model" =~ AMD ]]; then
    pacman -S --noconfirm --needed amd-ucode
    echo -e "░▒▓█ DETECTADA CPU AMD. █▓▒░\n"
else
    echo -e "░▒▓█ CPU NO RECONOCIDA: $model █▓▒░\n"
fi
sleep 3

pacman -S --noconfirm --needed \
awesome-terminal-fonts \
baobab \
base-devel \
bluez \
bluez-utils \
cifs-utils \
curl \
dkms \
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
gnome-music \
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
ttf-dejavu \
ttf-fira-code \
ttf-roboto \
unrar \
vim \
vlc \
vlc-plugins-all \
webp-pixbuf-loader \
wget \
wireplumber \
xdg-desktop-portal \
xdg-desktop-portal-gnome \
xorg-xwayland
echo -e "\n░▒▓█ PAQUETES BÁSICOS INSTALADOS. █▓▒░\n"; sleep 3

systemctl start NetworkManager && systemctl enable NetworkManager
echo -e "\n░▒▓█ 'NetworkManager' HABILITADO E INICIADO. █▓▒░\n"; sleep 3

systemctl start bluetooth && systemctl enable bluetooth
echo -e "\n░▒▓█ BLUETOOTH HABILITADO E INICIADO. █▓▒░\n"; sleep 3

systemctl enable gdm
echo -e "\n░▒▓█ 'gdm' HABILITADO. █▓▒░\n"; sleep 3

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
    echo -e "░▒▓█ NO SE INSTALARÁ NINGÚN PAQUETE PARA GAMING. █▓▒░\n"
elif [[ "$model" =~ Intel ]]; then
    pacman -S --noconfirm --needed mesa lib32-mesa vulkan-intel lib32-vulkan-intel gamemode lib32-gamemode
    echo -e "░▒▓█ PAQUETES GAMING INSTALADOS. █▓▒░\n"
elif [[ "$model" =~ AMD ]]; then
    pacman -S --noconfirm --needed mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon gamemode lib32-gamemode mangohud lib32-mangohud xf86-video-amdgpu
    echo -e "░▒▓█ PAQUETES GAMING INSTALADOS. █▓▒░\n"
else
    echo -e "░▒▓█ CPU NO RECONOCIDA: $model █▓▒░\n"
fi
sleep 3

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
sleep 3

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
echo -e "░▒▓█ EXTENSIONES LEGACY ELIMINADAS. █▓▒░\n"; sleep 3

sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=3/' /etc/default/grub
sed -i 's/^\(GRUB_DISABLE_OS_PROBER=false\)/\1/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "\n░▒▓█ GRUB CONFIGURADO. █▓▒░"; sleep 3

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo -e "░▒▓█ REPOSITORIO 'FlatHub' AÑADIDO. █▓▒░"; sleep 3

flatpak update -y
echo -e "\n░▒▓█ 'Flatpak' ACTUALIZADO. █▓▒░\n"; sleep 3

HUMAN=$(getent passwd 1000 | cut -d: -f1)
git clone https://github.com/rafa-ga/gnome-minimal.git "/opt/gnome-minimal"
chown -R "$HUMAN":"$HUMAN" "/opt/gnome-minimal"
chmod +x /opt/gnome-minimal/scripts/*
echo -e "\n░▒▓█ REPOSITORIO DE GIT CLONADO EN '/opt'. █▓▒░\n"; sleep 3

HUMAN_HOME=$(getent passwd "$HUMAN" | cut -d: -f6)
mkdir -p "$HUMAN_HOME/.config/systemd/user/graphical-session.target.wants"

cat > "$HUMAN_HOME/.config/systemd/user/my-gnome-minimal-post-1.service" <<'EOF'
[Unit]
Description=My Gnome minimal post-script 1
ConditionPathExists=!%h/.config/.my-gnome_minimal_post_1_done
After=graphical-session.target
Wants=graphical-session.target
PartOf=graphical-session.target

[Service]
Type=oneshot
ExecStart=/usr/bin/gnome-terminal -- bash -lc '/opt/gnome-minimal/scripts/my-gnome-minimal-post-1.sh'
RemainAfterExit=no

[Install]
WantedBy=graphical-session.target
EOF
echo -e "░▒▓█ DAEMON POST-INSTALACIÓN 1 CREADO EN '$HUMAN_HOME/.config/systemd/user'. █▓▒░\n"; sleep 3

chown "$HUMAN":"$HUMAN" "$HUMAN_HOME/.config/systemd/user/my-gnome-minimal-post-1.service"
ln -sf "$HUMAN_HOME/.config/systemd/user/my-gnome-minimal-post-1.service" "$HUMAN_HOME/.config/systemd/user/graphical-session.target.wants/my-gnome-minimal-post-1.service"
chown -h "$HUMAN":"$HUMAN" "$HUMAN_HOME/.config/systemd/user/graphical-session.target.wants/my-gnome-minimal-post-1.service"
echo -e "░▒▓█ DAEMON POST-INSTALACIÓN 1 HABILITADO. █▓▒░\n"; sleep 3

echo -e "░▒▓█ EL SISTEMA SE REINICIARÁ (1/3) EN: █▓▒░\n"; sleep 1
echo -e "3...\n"; sleep 1
echo -e "2...\n"; sleep 1
echo -e "1...\n"; sleep 1
reboot now

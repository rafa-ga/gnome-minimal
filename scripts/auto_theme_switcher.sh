#!/bin/bash

set -e

if [[ ! -f /var/lib/AccountsService/users/$(whoami) ]]; then
sudo tee /var/lib/AccountsService/users/$(whoami) > /dev/null <<EOF
[User]
Icon=/var/lib/AccountsService/icons/$(whoami)
SystemAccount=false
EOF
fi

cs=$(gsettings get org.gnome.desktop.interface color-scheme | tr -d \')

if [[ "$cs" == "default" || "$cs" == "prefer-light" ]]; then
    SCHEME="picture-uri"
elif [[ "$cs" == "prefer-dark" ]]; then
    SCHEME="picture-uri-dark"
else
    SCHEME="picture-uri-dark"
fi

num=$((RANDOM % 9 + 1))

case "$num" in
  1)
    gsettings set org.gnome.desktop.interface accent-color blue || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_azul.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_azul.png" "/var/lib/AccountsService/icons/$(whoami)"
    ;;
  2)
    gsettings set org.gnome.desktop.interface accent-color teal || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_cian.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_cian.png" "/var/lib/AccountsService/icons/$(whoami)"
    ;;
  3)
    gsettings set org.gnome.desktop.interface accent-color green || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_verde.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_verde.png" "/var/lib/AccountsService/icons/$(whoami)"
    ;;
  4)
    gsettings set org.gnome.desktop.interface accent-color yellow || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_amarillo.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_amarillo.png" "/var/lib/AccountsService/icons/$(whoami)"
    ;;
  5)
    gsettings set org.gnome.desktop.interface accent-color orange || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_naranja.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_naranja.png" "/var/lib/AccountsService/icons/$(whoami)"
    ;;
  6)
    gsettings set org.gnome.desktop.interface accent-color red || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_rojo.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_rojo.png" "/var/lib/AccountsService/icons/$(whoami)"
    ;;
  7)
    gsettings set org.gnome.desktop.interface accent-color pink || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_rosa.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_rosa.png" "/var/lib/AccountsService/icons/$(whoami)"
    ;;
  8)
    gsettings set org.gnome.desktop.interface accent-color purple || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_morado.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_morado.png" "/var/lib/AccountsService/icons/$(whoami)"
    ;;
  9)
    gsettings set org.gnome.desktop.interface accent-color slate || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_gris.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_gris.png" "/var/lib/AccountsService/icons/$(whoami)"
    ;;
esac
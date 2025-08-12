#!/bin/bash

set -e

echo
read -rp "¿QUÉ TEMA PREFIERES? CLARO (1) U OSCURO (2): " theme
echo

case "$theme" in
  1)
    gsettings set org.gnome.desktop.interface color-scheme 'default'
    ;;
  2)
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    ;;
  *)
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    ;;
esac

cs=$(gsettings get org.gnome.desktop.interface color-scheme | tr -d \')

if [[ "$cs" == "default" || "$cs" == "prefer-light" ]]; then
    SCHEME="picture-uri"
elif [[ "$cs" == "prefer-dark" ]]; then
    SCHEME="picture-uri-dark"
else
    SCHEME="picture-uri-dark"
fi

echo -e "¿QUÉ COLOR DE SISTEMA PREFIERES? "
echo -e "\n 1) Azul      2) Cian     3) Verde"
echo -e " 4) Amarillo  5) Naranja  6) Rojo"
echo -e " 7) Rosa      8) Morado   9) Gris\n"
read -rp "SELECCIONA [1-9]: " accent

case "$accent" in
  1)
    gsettings set org.gnome.desktop.interface accent-color blue || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_azul.png"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\133m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    ;;
  2)
    gsettings set org.gnome.desktop.interface accent-color teal || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_cian.png"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\16m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    ;;
  3)
    gsettings set org.gnome.desktop.interface accent-color green || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_verde.png"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\177m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    ;;
  4)
    gsettings set org.gnome.desktop.interface accent-color yellow || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_amarillo.png"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\111m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    ;;
  5)
    gsettings set org.gnome.desktop.interface accent-color orange || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_naranja.png"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1202m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    ;;
  6)
    gsettings set org.gnome.desktop.interface accent-color red || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_rojo.png"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1197m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    ;;
  7)
    gsettings set org.gnome.desktop.interface accent-color pink || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_rosa.png"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1206m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    ;;
  8)
    gsettings set org.gnome.desktop.interface accent-color purple || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_morado.png"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1135m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    ;;
  9)
    gsettings set org.gnome.desktop.interface accent-color slate || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_gris.png"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1250m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    ;;
  *)
    gsettings set org.gnome.desktop.interface accent-color blue || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_azul.png"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1133m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    ;;
esac
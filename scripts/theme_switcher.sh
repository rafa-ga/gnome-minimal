#!/bin/bash

set -e

if [[ ! -f /var/lib/AccountsService/users/$(whoami) ]]; then
sudo tee /var/lib/AccountsService/users/$(whoami) > /dev/null <<EOF
[User]
Icon=/var/lib/AccountsService/icons/$(whoami)
SystemAccount=false
EOF
fi

echo
read -rp "¿QUÉ TEMA PREFIERES? CLARO (1) U OSCURO (2): " theme
echo

case "$theme" in
  1)
    gsettings set org.gnome.desktop.interface color-scheme 'default'
    echo -e "\n░▒▓█ TEMA CLARO SELECCIONADO. █▓▒░\n"
    ;;
  2)
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    echo -e "\n░▒▓█ TEMA OSCURO SELECCIONADO. █▓▒░\n"
    ;;
  *)
    echo -e "\n░▒▓█ OPCIÓN NO VÁLIDA. █▓▒░\n"
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

echo
echo -e "\n¿QUÉ COLOR DE SISTEMA PREFIERES? "
echo " 1) Azul      2) Cian     3) Verde"
echo " 4) Amarillo  5) Naranja  6) Rojo"
echo " 7) Rosa      8) Morado   9) Gris"
echo "10) Rotativo"
read -rp "SELECCIONA [1-10]: " accent
echo

case "$accent" in
  1)
    gsettings set org.gnome.desktop.interface accent-color blue || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_azul.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_azul.png" "/var/lib/AccountsService/icons/$(whoami)"
    echo -e "\n░▒▓█ SELECCIONADO COLOR AZUL. █▓▒░\n"
    ;;
  2)
    gsettings set org.gnome.desktop.interface accent-color teal || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_cian.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_cian.png" "/var/lib/AccountsService/icons/$(whoami)"
    echo -e "\n░▒▓█ SELECCIONADO COLOR CIAN. █▓▒░\n"
    ;;
  3)
    gsettings set org.gnome.desktop.interface accent-color green || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_verde.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_verde.png" "/var/lib/AccountsService/icons/$(whoami)"
    echo -e "\n░▒▓█ SELECCIONADO COLOR VERDE. █▓▒░\n"
    ;;
  4)
    gsettings set org.gnome.desktop.interface accent-color yellow || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_amarillo.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_amarillo.png" "/var/lib/AccountsService/icons/$(whoami)"
    echo -e "\n░▒▓█ SELECCIONADO COLOR AMARILLO. █▓▒░\n"
    ;;
  5)
    gsettings set org.gnome.desktop.interface accent-color orange || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_naranja.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_naranja.png" "/var/lib/AccountsService/icons/$(whoami)"
    echo -e "\n░▒▓█ SELECCIONADO COLOR NARANJA. █▓▒░\n"
    ;;
  6)
    gsettings set org.gnome.desktop.interface accent-color red || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_rojo.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_rojo.png" "/var/lib/AccountsService/icons/$(whoami)"
    echo -e "\n░▒▓█ SELECCIONADO COLOR ROJO. █▓▒░\n"
    ;;
  7)
    gsettings set org.gnome.desktop.interface accent-color pink || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_rosa.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_rosa.png" "/var/lib/AccountsService/icons/$(whoami)"
    echo -e "\n░▒▓█ SELECCIONADO COLOR ROSA. █▓▒░\n"
    ;;
  8)
    gsettings set org.gnome.desktop.interface accent-color purple || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_morado.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_morado.png" "/var/lib/AccountsService/icons/$(whoami)"
    echo -e "\n░▒▓█ SELECCIONADO COLOR MORADO. █▓▒░\n"
    ;;
  9)
    gsettings set org.gnome.desktop.interface accent-color slate || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_gris.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_gris.png" "/var/lib/AccountsService/icons/$(whoami)"
    echo -e "\n░▒▓█ SELECCIONADO COLOR GRIS. █▓▒░\n"
    ;;
  10)
    CRONLINE="0 0 * * * /opt/gnome-minimal/scripts/theme_switcher.sh"
    ( crontab -l 2>/dev/null | grep -Fxq "$CRONLINE" ) || \
    ( crontab -l 2>/dev/null; echo "$CRONLINE" ) | crontab -
    echo -e "\n░▒▓█ ROTACIÓN SELECCIONADA. █▓▒░\n"
    ;;
  *)
    echo -e "\n░▒▓█ OPCIÓN NO VÁLIDA. █▓▒░\n"
    gsettings set org.gnome.desktop.interface accent-color blue || true
    sudo cp "/opt/gnome-minimal/imagenes/avatar_azul.png" "/var/lib/AccountsService/icons/$(whoami)"
    ;;
esac

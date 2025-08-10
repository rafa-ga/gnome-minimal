#!/bin/bash

set -e

dconf load /org/gnome/nautilus/ < "/opt/gnome-minimal/configuracion/nautilus.conf"
echo -e "\n░▒▓█ 'Nautilus' CONFIGURADO. █▓▒░\n"
sleep 3

dconf load /org/gnome/desktop/app-folders/ < "/opt/gnome-minimal/configuracion/app-folders.conf"
echo -e "\n░▒▓█ DASHBOARD CONFIGURADO. █▓▒░\n"
sleep 3

EXT_DIR="$HOME/.local/share/gnome-shell/extensions"

for ext in "$EXT_DIR"/*; do
    SCHEMAS_DIR="$ext/schemas"

    if [[ ! -f "$SCHEMAS_DIR/gschemas.compiled" ]]; then
        glib-compile-schemas "$SCHEMAS_DIR"
        gnome-extensions enable $(basename "$ext")
        echo -e "\n░▒▓█ ACTIVADO '$(basename "$ext")'. █▓▒░\n"
    else
        gnome-extensions enable $(basename "$ext")
        echo -e "\n░▒▓█ ACTIVADO '$(basename "$ext")'. █▓▒░\n"
    fi
done

dconf load /org/gnome/shell/ < "/opt/gnome-minimal/configuracion/gnome-shell.conf"
echo -e "\n░▒▓█ EXTENSIONES CONFIGURADAS. █▓▒░\n"
sleep 3

echo -e "\n░▒▓█ REINICIANDO EN 3... █▓▒░\n"
sleep 1
echo -e "\n░▒▓█ REINICIANDO EN 2... █▓▒░\n"
sleep 1
echo -e "\n░▒▓█ REINICIANDO EN 1... █▓▒░\n"
sleep 1
sudo reboot now
#!/bin/bash

set -e

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

dconf load /org/gnome/shell/extensions/ < "$HOME/gnome-minimal/Config/extensions.conf"

echo -e "\n░▒▓█ EXTENSIONES CONFIGURADAS. █▓▒░\n"
sleep 3

echo -e "\n░▒▓█ REINICIANDO EN 3... █▓▒░\n"
sleep 1
echo -e "\n░▒▓█ REINICIANDO EN 2... █▓▒░\n"
sleep 1
echo -e "\n░▒▓█ REINICIANDO EN 1... █▓▒░\n"
sleep 1
sudo reboot now
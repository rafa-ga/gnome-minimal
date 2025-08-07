#!/bin/bash

set -e

gsettings set org.gnome.desktop.background picture-uri "file:///home/naoki/wallpaper_kanagawa.png"
gsettings set org.gnome.desktop.background picture-uri-dark "file:///home/naoki/wallpaper_kanagawa.png"

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

cat << 'EOF' >> ~/gnome-extensions-settings.conf
[alphabetical-app-grid]
folder-order-position='start'

[auto-accent-colour]
hide-indicator=true
highlight-mode=true

[dash-to-dock]
background-color='rgb(98,160,234)'
background-opacity=0.5
click-action='focus-or-appspread'
custom-background-color=true
dash-max-icon-size=36
disable-overview-on-startup=true
dock-fixed=true
dock-position='BOTTOM'
height-fraction=0.90000000000000002
show-apps-always-in-the-edge=true
show-apps-at-top=true
show-mounts=false
transparency-mode='FIXED'

[tophat]
cpu-display='numeric'
fs-display='numeric'
fs-hide-in-menu='/boot'
mem-abs-units=true
mem-display='numeric'
mount-to-monitor='/'
position-in-panel='left'
show-menu-actions=false
EOF

dconf load /org/gnome/shell/extensions/ < ~/gnome-extensions-settings.conf

echo -e "\n░▒▓█ EXTENSIONES CONFIGURADAS. █▓▒░\n"

sudo reboot now
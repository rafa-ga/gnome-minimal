#!/bin/bash

set -e

echo -e "\n░▒▓█ INICIANDO TERCERA Y ÚLTIMA FASE. █▓▒░\n"; sleep 3

rm -f "$HOME/.config/.my-gnome_minimal_post_1_done"
touch "$HOME/.config/.my-gnome_minimal_post_2_done"

dconf load /org/gnome/nautilus/ < "/opt/gnome-minimal/configuracion/nautilus.conf"
echo -e "░▒▓█ 'Nautilus' CONFIGURADO. █▓▒░\n"; sleep 3

dconf load /org/gnome/desktop/app-folders/ < "/opt/gnome-minimal/configuracion/app-folders.conf"
echo -e "░▒▓█ DASHBOARD CONFIGURADO. █▓▒░\n"; sleep 3

EXT_DIR="$HOME/.local/share/gnome-shell/extensions"

for ext in "$EXT_DIR"/*; do
    SCHEMAS_DIR="$ext/schemas"

    if [[ ! -f "$SCHEMAS_DIR/gschemas.compiled" ]]; then
        glib-compile-schemas "$SCHEMAS_DIR"
        gnome-extensions enable $(basename "$ext")
        echo -e "░▒▓█ ACTIVADO '$(basename "$ext")'. █▓▒░\n"
    else
        gnome-extensions enable $(basename "$ext")
        echo -e "░▒▓█ ACTIVADO '$(basename "$ext")'. █▓▒░\n"
    fi
done
sleep 3

dconf load /org/gnome/shell/ < "/opt/gnome-minimal/configuracion/gnome-shell.conf"
echo -e "░▒▓█ EXTENSIONES CONFIGURADAS. █▓▒░\n"; sleep 3

echo "¿QUIERES INSTALAR ALGUNA DE LAS SIGUIENTES APLICACIONES PARA GAMING?"
echo -e "\n 0) Ninguna."
echo " 1) Steam."
echo " 2) Heroic Games."
echo " 3) Lutris."
echo " 4) ProtonPlus."
echo -e " 5) Discord.\n"
read -rp  "PUEDES ELEGIR VARIAS OPCIONES (SEPARADAS POR ESPACIOS): " opciones
echo

for i in $opciones; do
    case "$i" in
        0)
            echo -e "░▒▓█ NO SE INSTALARÁ NINGUNA APLICACIÓN █▓▒░\n"
            break
            ;;
        1)
            echo -e "░▒▓█ INSTALANDO 'Steam'... █▓▒░\n"
            sudo pacman -Syu --noconfirm steam
            ;;
        2)
            echo -e "░▒▓█ INSTALANDO 'Heroic Games Launcher'... █▓▒░\n"
            yay -S --noconfirm heroic-games-launcher
            echo 'NoDisplay=true' | sudo tee -a "/usr/share/applications/electron36.desktop" > /dev/null
            ;;
        3)
            echo -e "░▒▓█ INSTALANDO 'Lutris'... █▓▒░\n"
            sudo pacman -Syu --noconfirm lutris
            ;;
        4)
            echo -e "░▒▓█ INSTALANDO 'ProtonPlus'... █▓▒░\n"
            yay -S --noconfirm protonplus
            ;;
        5)
            echo -e "░▒▓█ INSTALANDO 'Discord'... █▓▒░\n"
            sudo pacman -Syu --noconfirm discord
            ;;
        *)
            echo "░▒▓█ '$i' NO ES UNA OPCIÓN VÁLIDA. █▓▒░\n"
            ;;
    esac
done
sleep 3

if [[ ! -f /var/lib/AccountsService/users/$(whoami) ]]; then
sudo tee /var/lib/AccountsService/users/$(whoami) > /dev/null <<EOF
[User]
Icon=/var/lib/AccountsService/icons/$(whoami)
SystemAccount=false
EOF
fi

read -rp "¿QUÉ TEMA PREFIERES? CLARO (1) U OSCURO (2): " theme
echo

case "$theme" in
  1)
    gsettings set org.gnome.desktop.interface color-scheme 'default'
    echo -e "░▒▓█ TEMA CLARO SELECCIONADO. █▓▒░\n"
    ;;
  2)
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    echo -e "░▒▓█ TEMA OSCURO SELECCIONADO. █▓▒░\n"
    ;;
  *)
    echo -e "░▒▓█ OPCIÓN NO VÁLIDA. █▓▒░\n"
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

echo "¿QUÉ COLOR DE SISTEMA PREFIERES? "
echo -e "\n 1) Azul      2) Cian     3) Verde"
echo " 4) Amarillo  5) Naranja  6) Rojo"
echo -e " 7) Rosa      8) Morado   9) Gris\n"
read -rp "SELECCIONA [1-9]: " accent
echo

case "$accent" in
  1)
    gsettings set org.gnome.desktop.interface accent-color blue || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_azul.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_azul.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\133m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "░▒▓█ SELECCIONADO COLOR AZUL. █▓▒░\n"
    ;;
  2)
    gsettings set org.gnome.desktop.interface accent-color teal || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_cian.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_cian.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\16m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "░▒▓█ SELECCIONADO COLOR CIAN. █▓▒░\n"
    ;;
  3)
    gsettings set org.gnome.desktop.interface accent-color green || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_verde.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_verde.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\177m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "░▒▓█ SELECCIONADO COLOR VERDE. █▓▒░\n"
    ;;
  4)
    gsettings set org.gnome.desktop.interface accent-color yellow || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_amarillo.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_amarillo.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\111m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "░▒▓█ SELECCIONADO COLOR AMARILLO. █▓▒░\n"
    ;;
  5)
    gsettings set org.gnome.desktop.interface accent-color orange || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_naranja.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_naranja.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1202m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "░▒▓█ SELECCIONADO COLOR NARANJA. █▓▒░\n"
    ;;
  6)
    gsettings set org.gnome.desktop.interface accent-color red || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_rojo.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_rojo.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1197m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "░▒▓█ SELECCIONADO COLOR ROJO. █▓▒░\n"
    ;;
  7)
    gsettings set org.gnome.desktop.interface accent-color pink || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_rosa.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_rosa.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1206m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "░▒▓█ SELECCIONADO COLOR ROSA. █▓▒░\n"
    ;;
  8)
    gsettings set org.gnome.desktop.interface accent-color purple || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_morado.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_morado.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1135m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "░▒▓█ SELECCIONADO COLOR MORADO. █▓▒░\n"
    ;;
  9)
    gsettings set org.gnome.desktop.interface accent-color slate || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_gris.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_gris.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1250m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "░▒▓█ SELECCIONADO COLOR GRIS. █▓▒░\n"
    ;;
  *)
    echo -e "░▒▓█ OPCIÓN NO VÁLIDA. █▓▒░\n"
    gsettings set org.gnome.desktop.interface accent-color blue || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file:///opt/gnome-minimal/imagenes/wallpaper_azul.png"
    sudo cp "/opt/gnome-minimal/imagenes/avatar_azul.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1133m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    ;;
esac

mv "/opt/gnome-minimal/configuracion/theme_switcher.desktop" "$HOME/.local/share/applications"
chmod +x "$HOME/.local/share/applications/theme_switcher.desktop"
echo -e "░▒▓█ AÑADIDO 'Theme Switcher' AL DASHBOARD. █▓▒░\n"

rm -f "$HOME/.config/.my-gnome_minimal_post_2_done"
rm -f "$HOME/.config/systemd/user/my-gnome-minimal-post-2.service"
rm -rf "$HOME/.config/systemd/user/graphical-session.target.wants"
echo -e "░▒▓█ SERVICIO POST-INSTALACIÓN 2 ELIMINADO. █▓▒░\n"; sleep 3

rm -rf "/opt/gnome-minimal/configuracion"
rm -f /opt/gnome-minimal/scripts/my-gnome-minimal-post-*
rm -f "/opt/gnome-minimal/my-gnome-minimal.sh"
echo -e "░▒▓█ SCRIPTS DE INSTALACIÓN ELIMINADOS. █▓▒░\n"; sleep 3

echo -e "░▒▓█ EL SISTEMA SE REINICIARÁ (3/3) EN: █▓▒░\n"; sleep 1
echo -e "3...\n"; sleep 1
echo -e "2...\n"; sleep 1
echo -e "1...\n"; sleep 1
systemctl reboot

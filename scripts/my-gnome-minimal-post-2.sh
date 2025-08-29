#!/bin/bash

set -e

echo -e "\n░▒▓█ INICIANDO TERCERA Y ÚLTIMA FASE. █▓▒░\n"; sleep 1

rm -f "$HOME/.config/.my-gnome_minimal_post_1_done"
touch "$HOME/.config/.my-gnome_minimal_post_2_done"

dconf load /org/gnome/nautilus/ < "/opt/gnome-minimal/configuracion/nautilus.conf"
echo -e "░▒▓█ 'Nautilus' CONFIGURADO. █▓▒░\n"; sleep 1

dconf load /org/gnome/desktop/app-folders/ < "/opt/gnome-minimal/configuracion/app-folders.conf"
echo -e "░▒▓█ DASHBOARD CONFIGURADO. █▓▒░\n"; sleep 1

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
sleep 1

dconf load /org/gnome/shell/ < "/opt/gnome-minimal/configuracion/gnome-shell.conf"
echo -e "░▒▓█ EXTENSIONES CONFIGURADAS. █▓▒░\n"; sleep 1

read -rp  "¿QUIERES INSTALAR 'Flatpak'? SI (1), NO (2): " flat
echo

case "$flat" in
  1)
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	echo -e "░▒▓█ REPOSITORIO 'FlatHub' AÑADIDO. █▓▒░"; sleep 1

	flatpak update -y
	echo -e "░▒▓█ 'Flatpak' ACTUALIZADO. █▓▒░\n"; sleep 1

	flatpak install -y flatseal
	echo -e "░▒▓█ 'Flatseal' INSTALADO. █▓▒░\n"; sleep 1
    ;;
  2)
    echo -e "░▒▓█ NO SE INSTALARÁ 'Flatpak'. █▓▒░\n"
    ;;
  *)
    echo -e "░▒▓█ '$flat' NO ES UNA OPCIÓN VÁLIDA. █▓▒░\n"
    ;;
esac

echo "¿QUIERES INSTALAR ALGUNA DE LAS SIGUIENTES APLICACIONES PARA GAMING?"
echo -e "\n 0) Ninguna."
echo " 1) Discord."
echo " 2) Heroic Games."
echo " 3) Lutris."
echo " 4) ProtonPlus."
echo -e " 5) Steam.\n"
read -rp  "PUEDES ELEGIR VARIAS OPCIONES (SEPARADAS POR ESPACIOS): " gapps

for i in $gapps; do
    case "$i" in
        0)
            echo -e "\n░▒▓█ NO SE INSTALARÁ NINGUNA APLICACIÓN. █▓▒░\n"
            break
            ;;
        1)
            echo -e "\n░▒▓█ INSTALANDO 'Discord'... █▓▒░\n"
            sudo pacman -S --noconfirm discord
            ;;
        2)
            echo -e "\n░▒▓█ INSTALANDO 'Heroic Games Launcher'... █▓▒░\n"
            yay -S --noconfirm heroic-games-launcher
            echo 'NoDisplay=true' | sudo tee -a "/usr/share/applications/electron36.desktop" > /dev/null
            ;;
        3)
            echo -e "\n░▒▓█ INSTALANDO 'Lutris'... █▓▒░\n"
            sudo pacman -S --noconfirm lutris
            ;;
        4)
            echo -e "\n░▒▓█ INSTALANDO 'ProtonPlus'... █▓▒░\n"
            yay -S --noconfirm protonplus
            ;;
        5)
            echo -e "\n░▒▓█ INSTALANDO 'Steam'... █▓▒░\n"
            sudo pacman -S --noconfirm steam
            ;;
        *)
            echo -e "\n░▒▓█ '$i' NO ES UNA OPCIÓN VÁLIDA. █▓▒░\n"
            ;;
    esac
done
sleep 1

echo "¿QUIERES INSTALAR ALGUNA DE LAS SIGUIENTES HERRAMIENTAS?"
echo -e "\n 0) Ninguna."
echo " 1) CherryTree (cuaderno de notas)."
echo " 2) Code (build open-source de VSCode)."
echo " 3) Google Chrome."
echo " 4) GPU Screen Recorder (grabador de pantalla)."
echo " 5) Mozilla Firefox."
echo " 6) Soporte para dongle oficial de Microsoft."
echo " 7) Spotify."
echo -e " 8) Upscaler (reescalador de imágenes).\n"
read -rp  "PUEDES ELEGIR VARIAS OPCIONES (SEPARADAS POR ESPACIOS): " tools

for j in $tools; do
    case "$j" in
        0)
            echo -e "\n░▒▓█ NO SE INSTALARÁ NINGUNA APLICACIÓN. █▓▒░\n"
            break
            ;;
        1)
            echo -e "\n░▒▓█ INSTALANDO 'CherryTree'... █▓▒░\n"
            sudo pacman -S --noconfirm cherrytree
            ;;
        2)
            echo -e "\n░▒▓█ INSTALANDO 'Code'... █▓▒░\n"
            sudo pacman -S --noconfirm code
            echo 'NoDisplay=true' | sudo tee -a "/usr/share/applications/electron37.desktop" > /dev/null
            ;;
        3)
            echo -e "\n░▒▓█ INSTALANDO 'Google Chrome'... █▓▒░\n"
            yay -S --noconfirm google-chrome
            ;;
        4)
            echo -e "\n░▒▓█ INSTALANDO 'GPU Screen Recorder'... █▓▒░\n"
            yay -S --noconfirm gpu-screen-recorder gpu-screen-recorder-gtk
            ;;
        5)
            echo -e "\n░▒▓█ INSTALANDO 'Mozilla Firefox'... █▓▒░\n"
            sudo pacman -S --noconfirm firefox
            ;;
        6)
            echo -e "\n░▒▓█ INSTALANDO 'Soporte para dongle oficial de Microsoft'... █▓▒░\n"
            yay -S --noconfirm xone-dkms-git xone-dongle-firmware
            #echo xone-dongle | sudo tee /etc/modules-load.d/xone.conf
            #echo "blacklist xpad" | sudo tee /etc/modprobe.d/blacklist-xpad.conf
            ;;
        7)
            echo -e "\n░▒▓█ INSTALANDO 'Spotify'... █▓▒░\n"
            yay -S --noconfirm spotify
            ;;
        8)
            echo -e "\n░▒▓█ INSTALANDO 'Upscaler'... █▓▒░\n"
            yay -S --noconfirm upscaler
            echo 'NoDisplay=true' | sudo tee -a "/usr/share/applications/cmake-gui.desktop" > /dev/null
            ;;
        *)
            echo -e "\n░▒▓█ '$j' NO ES UNA OPCIÓN VÁLIDA. █▓▒░\n"
            ;;
    esac
done
sleep 1

mv "/opt/gnome-minimal/configuracion/mimeapps.list" "$HOME/.config"
chmod 600 "$HOME/.config/mimeapps.list"
echo -e "░▒▓█ TIPOS DE ARCHIVOS ASOCIADOS. █▓▒░\n"; sleep 1

if [[ ! -f /var/lib/AccountsService/users/$(whoami) ]]; then
sudo tee /var/lib/AccountsService/users/$(whoami) > /dev/null <<EOF
[User]
Icon=/var/lib/AccountsService/icons/$(whoami)
SystemAccount=false
EOF
fi

echo
read -rp "¿QUÉ TEMA PREFIERES? CLARO (1) U OSCURO (2): " theme
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

echo -e "\n¿QUÉ COLOR DE SISTEMA PREFIERES? "
echo -e "\n 1) Azul      2) Cian     3) Verde"
echo " 4) Amarillo  5) Naranja  6) Rojo"
echo -e " 7) Rosa      8) Morado   9) Gris\n"
read -rp "SELECCIONA [1-9]: " accent

case "$accent" in
  1)
    gsettings set org.gnome.desktop.interface accent-color blue || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file://$HOME/.local/share/backgrounds/wallpaper_azul.png"
    cp "/usr/share/pixmaps/faces/avatar_azul.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\133m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "\n░▒▓█ SELECCIONADO COLOR AZUL. █▓▒░\n"
    ;;
  2)
    gsettings set org.gnome.desktop.interface accent-color teal || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file://$HOME/.local/share/backgrounds/wallpaper_cian.png"
    cp "/usr/share/pixmaps/faces/avatar_cian.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\16m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "\n░▒▓█ SELECCIONADO COLOR CIAN. █▓▒░\n"
    ;;
  3)
    gsettings set org.gnome.desktop.interface accent-color green || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file://$HOME/.local/share/backgrounds/wallpaper_verde.png"
    cp "/usr/share/pixmaps/faces/avatar_verde.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\177m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "\n░▒▓█ SELECCIONADO COLOR VERDE. █▓▒░\n"
    ;;
  4)
    gsettings set org.gnome.desktop.interface accent-color yellow || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file://$HOME/.local/share/backgrounds/wallpaper_amarillo.png"
    cp "/usr/share/pixmaps/faces/avatar_amarillo.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\111m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "\n░▒▓█ SELECCIONADO COLOR AMARILLO. █▓▒░\n"
    ;;
  5)
    gsettings set org.gnome.desktop.interface accent-color orange || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file://$HOME/.local/share/backgrounds/wallpaper_naranja.png"
    cp "/usr/share/pixmaps/faces/avatar_naranja.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1202m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "\n░▒▓█ SELECCIONADO COLOR NARANJA. █▓▒░\n"
    ;;
  6)
    gsettings set org.gnome.desktop.interface accent-color red || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file://$HOME/.local/share/backgrounds/wallpaper_rojo.png"
    cp "/usr/share/pixmaps/faces/avatar_rojo.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1197m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "\n░▒▓█ SELECCIONADO COLOR ROJO. █▓▒░\n"
    ;;
  7)
    gsettings set org.gnome.desktop.interface accent-color pink || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file://$HOME/.local/share/backgrounds/wallpaper_rosa.png"
    cp "/usr/share/pixmaps/faces/avatar_rosa.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1206m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "\n░▒▓█ SELECCIONADO COLOR ROSA. █▓▒░\n"
    ;;
  8)
    gsettings set org.gnome.desktop.interface accent-color purple || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file://$HOME/.local/share/backgrounds/wallpaper_morado.png"
    cp "/usr/share/pixmaps/faces/avatar_morado.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1135m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "\n░▒▓█ SELECCIONADO COLOR MORADO. █▓▒░\n"
    ;;
  9)
    gsettings set org.gnome.desktop.interface accent-color slate || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file://$HOME/.local/share/backgrounds/wallpaper_gris.png"
    cp "/usr/share/pixmaps/faces/avatar_gris.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1250m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    echo -e "\n░▒▓█ SELECCIONADO COLOR GRIS. █▓▒░\n"
    ;;
  *)
    echo -e "\n░▒▓█ OPCIÓN NO VÁLIDA. █▓▒░\n"
    gsettings set org.gnome.desktop.interface accent-color blue || true
    gsettings set org.gnome.desktop.background "$SCHEME" "file://$HOME/.local/share/backgrounds/wallpaper_azul.png"
    cp "/usr/share/pixmaps/faces/avatar_azul.png" "/var/lib/AccountsService/icons/$(whoami)"
    sed -i -E '/PS1="/ s/(\\e\[38;5;)[0-9]{1,3}m/\1133m/g' "$HOME/.bashrc" && source "$HOME/.bashrc"
    ;;
esac

mv "/opt/gnome-minimal/scripts/theme_switcher.sh" "$HOME/.config"
chmod +x "$HOME/.config/theme_switcher.sh"
mkdir -p "$HOME/.local/share/applications"
mv "/opt/gnome-minimal/configuracion/theme_switcher.desktop" "$HOME/.local/share/applications"
chmod +x "$HOME/.local/share/applications/theme_switcher.desktop"
echo -e "░▒▓█ AÑADIDO 'Theme Switcher' AL DASHBOARD. █▓▒░\n"

rm -f "$HOME/.config/.my-gnome_minimal_post_2_done" "$HOME/.config/systemd/user/my-gnome-minimal-post-2.service"
rm -rf "$HOME/.config/systemd/user/graphical-session.target.wants"
echo -e "░▒▓█ SERVICIO POST-INSTALACIÓN 2 ELIMINADO. █▓▒░\n"; sleep 1

sudo rm -rf "/opt/gnome-minimal"
echo -e "░▒▓█ SCRIPTS DE INSTALACIÓN ELIMINADOS. █▓▒░\n"; sleep 1

sudo sed -i '/^AutomaticLogin/ s/^/#/' /etc/gdm/custom.conf
echo -e "░▒▓█ LOGIN AUTOMÁTICO PARA '$(whoami)' DESHABILITADO. █▓▒░\n"; sleep 1

sudo mkdir -p /etc/NetworkManager/conf.d
echo -e "[device]\nwifi.backend=iwd" | sudo tee /etc/NetworkManager/conf.d/wifi-backend.conf > /dev/null
sudo systemctl disable --now wpa_supplicant.service
sudo systemctl mask wpa_supplicant.service
echo -e "\n░▒▓█ DESHABILITADO 'wpa_supplicant' Y HABILITADO 'iwd'. █▓▒░\n"; sleep 1

sudo systemctl disable --now systemd-networkd.service systemd-networkd.socket systemd-networkd-wait-online.service systemd-resolved.service
sudo systemctl mask systemd-networkd.service systemd-networkd.socket systemd-networkd-wait-online.service systemd-resolved.service
echo -e "\n░▒▓█ DESHABILITADOS 'systemd-networkd' Y 'systemd-resolved'. █▓▒░\n"; sleep 1

sudo sed -i '${/^.*NOPASSWD:.*$/d}' /etc/sudoers

echo -e "░▒▓█ EL SISTEMA SE REINICIARÁ (3/3) EN: █▓▒░\n"; sleep 1
echo -e "3...\n"; sleep 1
echo -e "2...\n"; sleep 1
echo -e "1...\n"; sleep 1
systemctl reboot

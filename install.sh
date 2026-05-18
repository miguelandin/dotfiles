#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

PACKAGES=(
    # WM y entorno
    hyprland
    hypridle
    hyprlock
    waybar
    rofi
    dunst
    # Terminal y shell
    kitty
    zsh
    zsh-autosuggestions
    fzf
    starship
    zoxide
    # Utilidades CLI
    lsd
    bat
    wl-clipboard
    # Editor
    neovim
    # Ficheros
    thunar
    # Fuente
    ttf-jetbrains-mono-nerd
    # Greeter
    sddm
)

echo "Comprobando dependencias..."
missing=()
for pkg in "${PACKAGES[@]}"; do
    pacman -Q "$pkg" &>/dev/null || missing+=("$pkg")
done

if [[ ${#missing[@]} -gt 0 ]]; then
    echo "Paquetes no instalados: ${missing[*]}"
    read -r -p "¿Instalar ahora? [s/N] " resp
    if [[ "$resp" =~ ^[sS]$ ]]; then
        sudo pacman -S --needed "${missing[@]}" && echo "Dependencias instaladas."
    else
        echo "Instala manualmente con: sudo pacman -S ${missing[*]}"
        exit 1
    fi
fi

echo "Instalando dotfiles..."

# ~/.config/* — enlaza cada subdirectorio
for src in "$DOTFILES/config"/*/; do
    name="$(basename "$src")"
    [[ "$name" == "zsh" ]] && continue
    dst="$HOME/.config/$name"
    mkdir -p "$(dirname "$dst")"
    ln -sfn "$src" "$dst"
    echo "  $dst"
done

# ~/.zshrc — caso especial, no va en .config
ln -sfn "$DOTFILES/config/zsh/zshrc" "$HOME/.zshrc"
echo "  $HOME/.zshrc"

# SDDM
if [[ ! -d /usr/share/sddm/themes/sugar-candy ]]; then
    echo "Tema sugar-candy no encontrado en /usr/share/sddm/themes/sugar-candy"
    echo "Instálalo manualmente: yay -S sddm-theme-sugar-candy"
    exit 1
fi
sudo mkdir -p /etc/sddm.conf.d
sudo cp "$DOTFILES/sddm/sddm.conf.d/theme.conf" /etc/sddm.conf.d/theme.conf
sudo cp "$DOTFILES/sddm/sugar-candy/theme.conf" /usr/share/sddm/themes/sugar-candy/theme.conf
echo "  /etc/sddm.conf.d/theme.conf"
echo "  /usr/share/sddm/themes/sugar-candy/theme.conf"

# Wallpapers
mkdir -p "$HOME/Pictures/wallpapers"
cp -n "$DOTFILES/wallpapers/"* "$HOME/Pictures/wallpapers/"
echo "  ~/Pictures/wallpapers"

echo "Listo."

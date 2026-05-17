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
)

echo "Comprobando dependencias..."
missing=()
for pkg in "${PACKAGES[@]}"; do
    pacman -Q "$pkg" &>/dev/null || missing+=("$pkg")
done

if [[ ${#missing[@]} -gt 0 ]]; then
    echo "Paquetes no instalados: ${missing[*]}"
    echo "Instala con: sudo pacman -S ${missing[*]}"
    exit 1
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

echo "Listo."

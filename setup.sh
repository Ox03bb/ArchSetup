#!/bin/bash
set -e

# =======================
# Colors
# =======================
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
RESET="\033[0m"

# =======================
# Functions
# =======================

banner() {
    echo -e "\n${CYAN}==============================${RESET}"
    echo -e "${CYAN}$1${RESET}"
    echo -e "${CYAN}==============================${RESET}\n"
}

update_system() {
    banner "Updating system"
    sudo pacman -Syu --noconfirm
    echo -e "${GREEN}System updated.${RESET}"
}

install_packages() {
    banner "Installing essential packages"

    # Official repository packages
    sudo pacman -S --noconfirm --needed \
        git curl wget base-devel python go nodejs npm \
        zsh vim code docker docker-compose \
        zip unzip htop fzf wireshark-cli wireshark-qt btop zellij

    echo -e "${GREEN}Base and developer packages installed.${RESET}"

    # Install yay (AUR helper) if not present
    if ! command -v yay >/dev/null 2>&1; then
        banner "Installing yay (AUR helper)"
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd -
        echo -e "${GREEN}yay installed.${RESET}"
    else
        echo -e "${YELLOW}yay already installed.${RESET}"
    fi

    # AUR packages
    banner "Installing AUR packages"
    yay -S --noconfirm --needed \
        postman burpsuite brave-bin free-download-manager

    echo -e "${GREEN}All packages installed.${RESET}"
}

setup_aliases() {
    banner "Configuring Git and terminal aliases"

    # -----------------------
    # Git aliases
    # -----------------------
    git config --global alias.st status
    git config --global alias.chk checkout
    git config --global alias.br branch
    git config --global alias.cm "commit -m"
    git config --global alias.last "log -1 HEAD"
    git config --global alias.lg "log --oneline --graph --decorate --all"

    echo -e "${GREEN}Git aliases configured.${RESET}"

    # -----------------------
    # Terminal aliases
    # -----------------------
    ZSHRC="$HOME/.zshrc"

    # Define aliases
    TERMINAL_ALIASES=$(cat <<'EOF'

# ===== Custom Aliases =====
alias dcd="docker compose down"
alias dcu="docker compose up -d"
alias dcl="docker compose logs -f"
alias dcb="docker compose build"
alias dps="docker ps"
alias di="docker images"
alias drm="docker rm"

alias ls="lsd"
alias pygenv="source /home/ox03bb/.genv/bin/activate"

alias mk="minikube"
alias kc="kubectl"

alias json="jq ."
alias please="sudo"
alias c="clear"

alias py="python3"

# ==========================
EOF
)

    # Append if not already present
    if ! grep -q "Custom Aliases" "$ZSHRC"; then
        echo "$TERMINAL_ALIASES" >> "$ZSHRC"
        echo -e "${GREEN}Terminal aliases added to .zshrc.${RESET}"
    else
        echo -e "${YELLOW}Terminal aliases already present in .zshrc.${RESET}"
    fi
}

install_ohmyzsh() {
    banner "Installing Oh My Zsh"
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo -e "${GREEN}Oh My Zsh installed.${RESET}"
    else
        echo -e "${YELLOW}Oh My Zsh already installed.${RESET}"
    fi
}

set_default_shell() {
    banner "Setting Zsh as default shell"
    if [ "$SHELL" != "$(which zsh)" ]; then
        chsh -s "$(which zsh)"
        echo -e "${GREEN}Zsh set as default shell.${RESET}"
    else
        echo -e "${YELLOW}Zsh is already the default shell.${RESET}"
    fi
}

install_zsh_plugins() {
    banner "Installing Zsh plugins"
    ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" 2>/dev/null || true
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" 2>/dev/null || true

    if ! grep -q "zsh-autosuggestions" ~/.zshrc; then
        sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
        echo -e "${GREEN}Plugins added to .zshrc.${RESET}"
    else
        echo -e "${YELLOW}Plugins already present in .zshrc.${RESET}"
    fi
}

final_message() {
    banner "Setup Complete"
    echo -e "${BLUE}Restart your terminal or run:${RESET} ${YELLOW}exec zsh${RESET}"
    echo -e "${CYAN}Configuration finished.${RESET}"
}

# =======================
# Main Execution
# =======================

main() {
    update_system
    install_packages
    install_ohmyzsh
    set_default_shell
    install_zsh_plugins
	setup_aliases
    final_message
}

main

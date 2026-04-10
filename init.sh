#!/bin/bash

# --- Simple Logging Helpers ---
log_header() { echo -e "\n\033[1;35m>>> $1 <<<\033[0m"; }
log_step()   { echo -e "\033[0;34m[PROCESS]\033[0m $1"; }
log_ok()     { echo -e "\033[0;32m[SUCCESS]\033[0m $1"; }
log_skip()   { echo -e "\033[0;33m[SKIPPING]\033[0m $1"; }

# 1. General Software
log_header "Installing General Software"
sudo apt install -y zsh git stow tmux curl wget xclip autojump ripgrep unzip gcc dotnet-sdk-10.0
log_ok "Base packages installed."

# 2. Git Config
log_header "Setting up Git Config"
if [ ! -f ~/.gitconfig ]; then
    cp ./.gitconfig.template ~/.gitconfig
    log_step "Template copied."

    read -p "Enter full name: " git_name
    read -p "Enter email: " git_email

    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    log_ok "Git identity set."
else
    log_skip ".gitconfig already exists."
fi

# 3. TMUX Plugin Manager
log_header "Installing TPM"
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    log_ok "TPM cloned."
else
    log_skip "TPM already present."
fi

# 4. Neovim
log_header "Installing Neovim"
NVIM_DIR="$HOME/programs/nvim"
if [ ! -d "$NVIM_DIR" ]; then
    log_step "Downloading Neovim v0.12.1..."
    TEMP_DIR=$(mktemp -d)
    wget "https://github.com/neovim/neovim/releases/download/v0.12.1/nvim-linux-x86_64.tar.gz" -O "$TEMP_DIR/nvim.tar.gz" -nv
    
    mkdir -p "$HOME/programs"
    tar -xzf "$TEMP_DIR/nvim.tar.gz" -C "$TEMP_DIR"
    mv "$TEMP_DIR/nvim-linux-x86_64" "$NVIM_DIR"
    rm -rf "$TEMP_DIR"
    log_ok "Neovim installed to $NVIM_DIR"
else
    log_skip "Neovim already exists."
fi

# 5. Stow
log_header "Running Stow"
stow . && log_ok "Dotfiles stowed."

# 6. Go Lang
log_header "Checking Go Lang"
if command -v go &> /dev/null; then
    log_skip "Go is already installed: $(go version)"
else
    log_step "Installing Go 1.23.1..."
    GO_TEMP=$(mktemp -d)
    curl -L "https://go.dev/dl/go1.23.1.linux-amd64.tar.gz" -o "$GO_TEMP/go.tar.gz"
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "$GO_TEMP/go.tar.gz"
    rm -rf "$GO_TEMP"
    log_ok "Go installed."
fi

# 7. LazyGit
log_header "Installing LazyGit"
go install github.com/jesseduffield/lazygit@latest && log_ok "LazyGit binary installed via Go."

# 8. Oh My Zsh
log_header "Installing Oh My Zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    log_ok "Oh My Zsh ready."
else
    log_skip "Oh My Zsh already exists."
fi

# 9. NVM & Node
log_header "Installing NVM & Node"
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    # Export so we can use it immediately in this script
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install 24
    log_ok "Node 24 installed."
else
    log_skip "NVM already installed."
fi

# 10. docker
log_header "Checking docker"
if command -v docker &> /dev/null; then
    log_skip "Docker is already installed"
else
    log_step "setup docker apt repository"
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    (
      echo "Types: deb"
      echo "URIs: https://download.docker.com/linux/ubuntu"
      echo "Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")"
      echo "Components: stable"
      echo "Architectures: $(dpkg --print-architecture)"
      echo "Signed-By: /etc/apt/keyrings/docker.asc"
    ) | sudo tee /etc/apt/sources.list.d/docker.sources

    sudo apt update

    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker

    log_step "docker installed."
fi

echo -e "\n\033[1;32mDONE!\033[0m Everything is set up."

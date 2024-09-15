#!/bin/bash

echo "#############################"
echo "# APT Installing some stuff #"
echo "#############################"

sudo apt install -y \
    zsh \
    git \
    stow \
    tmux \
    curl \
    xclip \
    autojump \
    ripgrep \
    unzip \
    gcc \
    default-jdk \
    python3-pip \
    dotnet-sdk-8.0 \
    hugo \

echo ""


echo "#############"
echo "# Gitconfig #"
echo "#############"

if [ ! -f ~/.gitconfig ]; then
    cp ./.gitconfig.template ~/.gitconfig
else
    echo ".gitconfig file already setup"
fi
echo ""


echo "###############"
echo "# Install TPM #"
echo "###############"

TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
    echo "$TPM_DIR directory is not empty"
fi
echo ""


echo "################"
echo "# Install nvim #"
echo "################"

NVIM_RELEASE_URL="https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz"
TEMP_DIR=$(mktemp -d)
TAR_FILE="$TEMP_DIR/nvim.tar.gz"
EXTRACT_DIR="$TEMP_DIR/nvim-linux64"
INSTALL_DIR="$HOME/programs"
NVIM_DIR="$INSTALL_DIR/nvim"

if [ ! -d "$NVIM_DIR" ]; then

    echo "Downloading Neovim..."
    curl -L -o "$TAR_FILE" "$NVIM_RELEASE_URL"

    echo "Extracting the file..."
    mkdir -p "$EXTRACT_DIR"
    tar -xzf "$TAR_FILE" -C "$EXTRACT_DIR"

    echo "Install to /home/katlego/programs"
    mkdir -p $INSTALL_DIR
    mv "$EXTRACT_DIR/nvim-linux64" "$INSTALL_DIR/nvim"

    echo "Cleaning up..."
    rm -rf "$TEMP_DIR"
else
    echo "nvim dir already exists"
fi

echo ""


echo "############"
echo "# Run stow #"
echo "############"

stow .
echo ""


echo "#############"
echo "# Oh my zsh #"
echo "#############"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo ""


echo "###########"
echo "# rust up #"
echo "###########"

if command -v rustc &> /dev/null
then
    echo "Rust is installed."
    rustc --version
else
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

echo ""


echo "#############################"
echo "# install node 20 using nvm #"
echo "#############################"

# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
# nvm install 20

echo ""


echo "###########"
echo "# go lang #"
echo "###########"

if command -v go &> /dev/null
then
    echo "Go is installed."
    go version
else
    GO_LANG_URL="https://go.dev/dl/go1.23.1.linux-amd64.tar.gz"
    GO_TEMP_DIR=$(mktemp -d)
    GO_TAR_FILE="$TEMP_DIR/go.tar.gz"

    echo "Downloading golang..."
    curl -L -o "$GO_TAR_FILE" "$GO_LANG_URL"

    echo "Installing go"
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf $GO_TAR_FILE 

    echo "Cleaning up..."
    rm -rf "$GO_TEMP_DIR"

fi

echo ""


echo "###################"
echo "# install lazygit #"
echo "###################"

go install github.com/jesseduffield/lazygit@latest

echo ""

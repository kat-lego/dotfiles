#!/bin/bash

echo "#############################"
echo "# APT Installing some stuff #"
echo "#############################"

apt install -y \
    zsh \
    git \
    stow \
    tmux \
    curl \
    xclip \
    autojump \
    ripgrep \
    unzip \
    python3-pip \
    default-jdk \
    rubygems \
    python3.12-venv \
    dotnet-sdk-8.0 \
    golang-go

echo ""

#####################################

echo "###############################"
echo "# Install Jetbrain Nerd Fonts #"
echo "###############################"

# Set variables
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"
FONT_DIR="$HOME/.fonts"
FONT_ZIP="/tmp/JetBrainsMono.zip"

# Download the font zip using curl
echo "Downloading JetBrainsMono font..."
curl -L -o "$FONT_ZIP" "$FONT_URL"

# Create the fonts directory if it doesn't exist
if [ ! -d "$FONT_DIR" ]; then
    echo "Creating fonts directory at $FONT_DIR..."
    mkdir -p "$FONT_DIR"
fi

# Unzip the downloaded font to the fonts directory and override existing files
echo "Unzipping font to $FONT_DIR (overriding existing files)..."
unzip -o "$FONT_ZIP" -d "$FONT_DIR"

# Clean up the zip file
echo "Cleaning up..."
rm "$FONT_ZIP"

# Update font cache
echo "Updating font cache..."
fc-cache -fv

echo "Font installation complete."
echo ""

##################################
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

##################################
echo "#############################"
echo "# Set kitty rose pine theme #"
echo "#############################"

kitty +kitten themes --reload-in=all Rosé Pine
echo ""

##################################
echo "############"
echo "# Run stow #"
echo "############"

# run stow
stow .
echo ""

##################################
echo "#############################"
echo "# install node 20 using nvm #"
echo "#############################"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
nvm install 20
echo ""


##################################
echo "###########"
echo "# rust up #"
echo "###########"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
echo ""

##################################
echo "#######################"
echo "# NVIM optional stuff #"
echo "#######################"

cargo install tree-sitter-cli
npm install -g neovim

echo ""



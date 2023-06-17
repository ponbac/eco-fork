#!/usr/bin/bash

declare -r SSH_DIR="${SSH_DIR:-"$HOME/.ssh"}"

# Add Neovim repository and update system
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt upgrade

# Install necessary dependencies
sudo apt install -y \
git \
curl \
fzf \
ripgrep \
locate \
neovim \
xclip

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Install nvm and node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install node

# Create SSH key if it doesn't exist and copy it to clipboard
if ! [ -f "$SSH_DIR/id_rsa.pub" ]; then
    echo "SSH key not found. Generating one..."
    ssh-keygen
fi

echo "Your public SSH key is:"
echo
cat "$SSH_DIR/id_rsa.pub"
echo
echo "Copying SSH key to clipboard..."
cat "$SSH_DIR/id_rsa.pub" | xclip -selection clipboard
echo "SSH key copied to clipboard! Paste it into your GitHub account."
echo "Press any key to continue when you are done..."
read -n 1

# Ask user if they now want to run the ecovim installer
echo "Do you want to run the ecovim installer now? [y/n]"
read -n 1
if [ "$REPLY" == "y" ]; then
    bash run.sh
fi
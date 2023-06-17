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
xclip \
unzip

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Install nvm and node
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
source ~/.bashrc
fnm install 18.16.0
fnm use 18.16.0

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
echo "https://github.com/settings/keys"
echo "Press any key to continue when you are done..."
read -n 1

echo
echo "You are now ready to execute the install script!"
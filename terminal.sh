#!/bin/bash

# Terminal Configuration Automation Script
# Terminal environment configuration based on Oh My Zsh

echo "Starting comfortable terminal environment setup..."

# Update system packages
echo "Updating system packages..."
if command -v apt-get &> /dev/null; then
    sudo apt-get update && sudo apt-get upgrade -y
elif command -v yum &> /dev/null; then
    sudo yum update -y
elif command -v dnf &> /dev/null; then
    sudo dnf update -y
fi

# Install dependencies
echo "Installing dependencies..."
if command -v apt-get &> /dev/null; then
    sudo apt-get install -y git curl wget zsh
elif command -v yum &> /dev/null; then
    sudo yum install -y git curl wget zsh
elif command -v dnf &> /dev/null; then
    sudo dnf install -y git curl wget zsh
fi

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install common plugins
echo "Installing plugins..."

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install Powerlevel10k theme
echo "Installing Powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install programmer fonts
# echo "Installing Nerd Fonts..."
# mkdir -p ~/.local/share/fonts
# cd ~/.local/share/fonts && curl -fLo "Meslo LG M Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/M/Regular/complete/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete.ttf

# Configure .zshrc file
echo "Configuring .zshrc file..."
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# Add plugins
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting sudo web-search copypath dirhistory history)/g' ~/.zshrc

# Add some useful aliases and configurations
cat << 'EOF' >> ~/.zshrc

# Custom aliases
# alias ll='ls -la'
# alias la='ls -A'
# alias l='ls -CF'
# alias cls='clear'
# alias ..='cd ..'
# alias ...='cd ../..'
# alias update='sudo apt update && sudo apt upgrade -y'
# alias ports='netstat -tulanp'

# History command settings
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Auto-completion settings
autoload -U compinit && compinit

# Enable fast directory switching
setopt AUTO_CD

# Optimize terminal startup speed
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true
EOF

# Change default shell to zsh
echo "Changing default shell to zsh..."
chsh -s $(which zsh)

echo "Configuration complete! Please log out and log back in or run 'source ~/.zshrc' to apply changes."
echo "When starting zsh for the first time, you'll enter the Powerlevel10k setup wizard for personalization."

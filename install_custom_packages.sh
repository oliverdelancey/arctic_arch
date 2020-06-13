#!/bin/bash

sudo pacman -S figlet
figlet "Installing Languages"
sudo pacman -S python python-pip ruby ruby-irb clang
curl https://sh.rustup.rs -sSf | sh
figlet "Installing Utilities"
sudo pacman -S htop vtop neofetch git
figlet "Installing zsh"
sudo pacman -S zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo pacman -S zsh-syntax-highlighting
nvim ~/.zshrc

#!/bin/bash

sudo pacman -S figlet
figlet "Installing Languages"
sudo pacman -S python python-pip ruby ruby-irb clang
figlet "Installing Utilities"
sudo pacman -S git htop vtop neofetch
figlet "Installing zsh"
sudo pacman -S zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo pacman -S zsh-syntax-highlighting
nvim ~/.zshrc

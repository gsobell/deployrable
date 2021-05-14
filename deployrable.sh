#!/bin/bash

git clone https://github.com/gsobell/dotfiles.git


sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

cd ~/dotfiles/packlist
ls -t | head -n1 | cat | paru -Syu 
exit 0

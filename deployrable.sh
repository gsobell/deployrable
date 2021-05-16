#!/bin/bash

echo 'deployrable v0.1'
sleep 1
echo 'MIT License, Copyright (c) 2021 gsobell'
clear

cd /home/$USER/

echo 'Cloning dotfile repo to local host'
git clone https://github.com/gsobell/dotfiles.git

# Initial dotfile deployment
mkdir -pv /home/$USER/.i3

mv -fv /home/$USER/dotfiles/.Xresources		/home/$USER/.Xresources
mv -fv /home/$USER/dotfiles/.bashrc		/home/$USER/.bashrc
mv -fv /home/$USER/dotfiles/.bash_profile	/home/$USER/.bash_profile
mv -fv /home/$USER/dotfiles/.vimrc		/home/$USER/.vimrc
mv -fv /home/$USER/dotfiles/.i3/config		/home/$USER/.i3/config

# Setting natural scrolling > Use xmodmap instead, look into libinput

if ! command -v paru &> /dev/null
	then
		echo 'Installing Paru'
		sudo pacman -S --needed base-devel
		git clone https://aur.archlinux.org/paru.git
		cd paru
		makepkg -si		
		mv /home/$USER/Paru 	/home/$USER/.Paru
	else    
		echo 'Paru already installed.'
	fi

	
	read -p "Install packages at this time? (Y/n)" yn
while true; do
	case $yn in
	[Yy]* ) ls /home/$USER/dotfiles/packlist > packversion.txt
	select PACKLIST in $(cat packversion.txt) exit; do
	case $PACKLIST in
	exit) echo "Exiting."
	break ;;
	*) echo "$PACKLIST"
	echo Installing "$PACKLIST";
	paru -S - < /home/"$USER"/dotfiles/packlist/"$PACKLIST"
	rm /home/$USER/packversion.txt
	esac
	done; break;;
	[Nn]* ) break;;
	* ) echo "Please answer yes or no.";sleep 1;;
	esac
done

clear
echo 'Cleaning up.'
sleep 1
rm -fdr /home/$USER/dotfiles
echo 'One moment please.'
sleep 1
echo "Setup complete, exiting deployrable."
sleep 1

exit 0

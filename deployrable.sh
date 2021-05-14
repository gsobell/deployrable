#!/bin/bash

echo 'deployrable v0.1'
sleep 1
echo 'MIT License, Copyright (c) 2021 gsobell'
clear

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

echo 'Installing Paru'
while true; do
	read -p "Install Paru at this time? (Y/n)" yn
	case $yn in
	[Yy]* ) sudo pacman -S --needed base-devel
		git clone https://aur.archlinux.org/paru.git
		cd paru
		makepkg -si;;	
	[Nn]* ) break;;
#	* ) echo 'Please answer (y/n).';;
	esac
done

while true; do
	read -p "Install packages at this time? (Y/n)" yn
	case $yn in
        [Yy]* ) ls /home/$USER/dotfiles/packlist > packversion.txt
		select PACKLIST in $(cat packversion.txt) exit; do 
   		case $PACKLIST in
      		exit) echo "exiting"
       	 	break ;;
       		*) echo "$PACKLIST"
		echo Installing "$PACKLIST";
		paru -S - < /home/"$USER"/dotfiles/packlist/"$PACKLIST"
		rm /home/$USER/packversion.txt
		esac
		done; break;;
        [Nn]* ) break;;
	* ) echo "Please answer (y/n).";;
    esac
done

clear
echo 'Cleaning up.'
sleep 1
mv /home/$USER/Paru 	/home/$USER/.Paru
mv /home/$USER/dotfiles /home/$USER/.dotfiles
echo 'One moment please.'
sleep 1
clear
echo "Setup complete, exiting deployrable."
sleep 1

exit 0

#!/bin/bash

echo 'deployrable v0.2'
sleep 1
echo 'MIT License, Copyright (c) 2021 gsobell'
clear

TEMP=$(mktemp -d -t gsobell.XXXXXXXXXX)
cd $TEMP

echo 'Checking if git is installed'
if ! command -v git &> /dev/null; then
    sudo pacman -S git
fi

echo 'Cloning dotfile repo to local host'
git clone https://github.com/gsobell/dotfiles.git

# Initial dotfile deployment
mkdir -pv $HOME/.i3

mv -fv dotfiles/.Xresources	$HOME/.Xresources
mv -fv dotfiles/.bashrc		$HOME/.bashrc
mv -fv dotfiles/.bash_profile	$HOME/.bash_profile
mv -fv dotfiles/.vimrc		$HOME/.vimrc
mv -fv dotfiles/.i3/config	$HOME/.i3/config
mv -v	dotfiles/.config/*	$HOME/.config
mv -v 	dotfiles/.*		$HOME/.*

mkdir -pv ~/Notes
mkdir -pv ~/"To Read"/Read

if ! command -v pacman &> /dev/null
then echo 'Non-arch based distro, not installing packages.'
		# Unknown distro clause
		if ! command -v apt &> /dev/null
		then 
		echo 'Non-debian based distro, not installing packages.'
		sleep 1
		echo 'Cleaning up.'
		sleep 1
		echo "Setup complete, exiting deployrable."
		sleep 1	
		exit 0
		# Debian clause
		else
		echo 'Assuming Debian based distro, attempting to install packages.'
		sleep 1
		#sudo apt update
		#sudo apt upgrade
		PKGMANAGER="sudo apt install"
		fi

else
		# Arch clause
		if ! command -v paru &> /dev/null
		then
		echo 'Refreshing databases'
		sudo pacman -Syy
		echo 'Installing Paru'
		sudo pacman -S --needed base-devel
		git clone https://aur.archlinux.org/paru.git
		cd paru
		makepkg -si
		cd $TEMP
		else
		echo 'Paru already installed, refreshing databases'
		sudo pacman -Syy
		PKGMANAGER="paru -S -"
		fi
fi
sleep 1

echo "Install packages at this time? (Y/n)"
read yn
while true; do
case $yn in
	[Yy]* ) ls $TEMP/dotfiles/.packlist > packversion.txt
		select PACKLIST in $(cat packversion.txt) diff exit; do
		case "$PACKLIST" in
		diff) echo "Choose two packages to compare:" ; 
			select PACK1 in $(cat packversion.txt); do echo "First package is $PACK1"; break; done;
			echo "Choose a second package"   	
			select PACK2 in $(cat packversion.txt); do echo "Second package is $PACK2"; break; done; 
				if ! command -v colordiff &> /dev/null;
				then  diff	$TEMP/dotfiles/.packlist/$PACK1 $TEMP/dotfiles/.packlist/$PACK2 ; 	
				else  colordiff $TEMP/dotfiles/.packlist/$PACK1 $TEMP/dotfiles/.packlist/$PACK2 ; 
				fi
			read -p "Press enter to continue"
			echo "Install one of these packages?"
			select PACKLIST in $PACK1 $PACK2; do echo "Installing $PACKLIST"; break; done;
			$PKGMANAGER $(cat $PACKLIST)
			break ;;
		exit) echo "Exiting."
			break ;;
		*) echo "$PACKLIST"
			echo Installing "$PACKLIST";
			$PKGMANAGER $(cat $PACKLIST)
		esac
		done; break;;
	[Nn]* ) break;;
		* ) echo "Please answer yes or no."; echo "Install packages now (Y/n)?"; read yn;;
esac
done


#if ! command -v nitrogen &> /dev/null && ! command -v feh &> /dev/null ; then echo "No background backend"; 
#else 		
#	select BACKGROUND in Default URL; do 
#		case $BACKGROUND in
#		Default) URL=$('https://i.imgur.com/o6BcMBy.jpg'); break;;
#		URL) echo "Please input image URL"; read URL ; break;
#		esac; done	
#	wget $URL > $TEMP/background.jpg;
#	sudo mv $TEMP/background.jpg /usr/share/backgrounds/.background.jpg ;
#	feh --bg-fill /usr/share/backgrounds/back.jpeg || nitrogen $HOME
#fi
	
echo 'Cleaning up.'
sleep 1
echo "Setup complete, exiting deployrable."
sleep 1
exit 0

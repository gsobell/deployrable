#!/bin/bash

echo 'deployrable v1.1.2'
sleep 1
echo 'MIT License, Copyright (c) 2021 gsobell'
clear

if [ ! -n "$BASH" ] # Verifying that shell is indeed bash
then 
	echo "Please run this script with bash.";
	echo "Would you like to attempt to run it anyway? (y/n)"
	read yn
	while true; do
	case $yn in
		[Yy]) break ;;
		[Nn]) echo "Setup failed, exiting deployrable"; 
			exit;;
	esac
	done
else :
fi

TEMP=$(mktemp -d -t gsobell.XXXXXXXXXX)
cd $TEMP

echo 'Checking if git is installed'
if ! command -v git &> /dev/null; then
    sudo pacman -S git   ||    
    sudo apt install git ||
    sudo yum install git ||
    sudo pkg install git ||
    sudo zypper install git ||  
    sudo install git ||
    echo "Git not installed, setup failed, exiting deployrable"; 
fi

echo 'Cloning dotfile repo to local host'
git clone https://github.com/gsobell/dotfiles.git

# Initial dotfile deployment 
# Organized according to strict XDG Base Directory Specification

cp -fv  dotfiles/.bashrc	$HOME/.bashrc
cp -fv  dotfiles/.bash_profile	$HOME/.bash_profile
cp -fvr	dotfiles/.config	$HOME/.config

mkdir -pv ~/Notes
mkdir -pv ~/"To Read"/Read

if ! command -v pacman &> /dev/null
then 		# Unknown distro clause
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
		echo 'Debian based distro, attempting to install packages.'
		sleep 1
		sudo apt update &&
		sudo apt upgrade &&
		PKGMANAGER="xargs sudo apt install"
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
			if ! command -v paru &> /dev/null
			then 	echo "Paru installation failed, fallback to yay"
				chars="/—\|"; for n in {1..20}; do echo -en "${chars:$(( i=(i+1) % ${#chars} )):1}" "\r"; sleep 0.15; done
				pacman -S --needed git base-devel
				git clone https://aur.archlinux.org/yay.git
				cd yay
				makepkg -si
				PKGMANAGER="yay -S -"
				
				if ! command -v yay &> /dev/null
				then echo "Yay installation failed, fallback to pacman"
				echo "To install packages from the AUR, try again."
				PKGMANAGER="pacman -S -"
				fi
			fi
		else
		echo 'Paru already installed, refreshing databases'
		sudo pacman -Syy
		PKGMANAGER="paru -S -"
		fi
fi
sleep 1

echo "Install packages at this time? (Y/n)"
read yn
echo "This host is running $XDG_SESSION_TYPE" # Prints display server
while true; do
case $yn in
	[Yy]* ) ls $TEMP/dotfiles/.config/packlist > packversion.txt
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
			$PKGMANAGER < dotfiles/.packlist/"$PACKLIST"
			break ;;
		exit) echo "Exiting."
			break ;;
		*) echo "$PACKLIST"
			echo Installing "$PACKLIST";
			$PKGMANAGER < dotfiles/.packlist/"$PACKLIST"
		esac
		done; break;;
	[Nn]* ) break;;
		* ) echo "Please answer yes or no."; echo "Install packages now (Y/n)?"; read yn;;
esac
done

echo "Install Sabaki? (y/n)" # Place AppImages here. Installing Sabaki and requisite Go engines. 
read yn
	while true; do
	case $yn in
	[Yy]*)  if ! command -v gnugo &> /dev/null 
		then $PKGMANAGER gnugo; fi 
		if ! command -v wget &> /dev/null
		then $PKGMANAGER wget; fi 
		sudo wget https://github.com/SabakiHQ/Sabaki/releases/download/v0.51.1/sabaki-v0.51.1-linux-x64.AppImage > /usr/local/bin/Sabaki ; break;;
	[Nn]*) echo "Skipping Sabaki and Go Engines."; break ;;
	esac
	done
# Automatic background placement; consider using feh
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

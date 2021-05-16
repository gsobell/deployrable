# deployrable
Bash script for deploying dotfiles and selected packages primarily on live enviroments and fresh installs.

## Usage
Run the following in the terminal emulator of your choice. You will be prompted for root if you choose to install PACKLIST. If there are existing dotfiles, they will be overwritten.
```bash
curl -O https://raw.githubusercontent.com/gsobell/deployrable/home/deployrable.sh
sh deployrable.sh
```
## Features

### Current
- Clones dotfiles from repo
- Moves dotfiles to appropriate directories
- Full package database syncronization
- Install AUR helper [PARU](https://github.com/morganamilo/paru)
- Install most recent list of packages (PACKLIST)

### Future
- Further interactivity
- Optional user supplied dotfile repo
- Compatibility across non-pacman distros
- Make seperate PACKLIST option for Wayland
- Diff functionality for PACKLIST
##
This software is provided "as is", without warranty of any kind. *Caveat emptor*.

# deployrable
Bash script for deploying dotfiles and selected packages primarily on live enviroments and fresh installs.

## Usage
Run the following in the terminal emulator of your choice. You will be prompted for root if you choose to install [PACKLIST](https://github.com/gsobell/dotfiles/tree/master/.packlist). If there are existing dotfiles, they will be overwritten. Script will not 
```bash
curl -O https://raw.githubusercontent.com/gsobell/deployrable/home/deployrable.sh
sh deployrable.sh
```
## Features

### Current
- Clones dotfiles from repo
- Moves dotfiles to appropriate directories
- Full package database synchronization
- Install AUR helper [PARU](https://github.com/morganamilo/paru)
- Install and compare most recent list of packages ([PACKLIST](https://github.com/gsobell/dotfiles/tree/master/.packlist))
- Smart distro detection for package manager

### Future
- No additional features are planned at this time.

##
This software is provided "as is", without warranty of any kind. *Caveat emptor*.

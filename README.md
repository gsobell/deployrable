# deployrable
A bash script for deploying dotfiles and selected packages primarily on live enviroments and fresh installs.

## Usage
Run the following in the terminal emulator of your choice. You will be prompted for root if you choose to install [PACKLIST](https://github.com/gsobell/dotfiles/tree/master/.packlist). If there are existing dotfiles, they will be overwritten. See below on how to use your own dotfiles.
```bash
curl -O https://raw.githubusercontent.com/gsobell/deployrable/home/deployrable.sh
sh deployrable.sh
```
## Features

### Current
- Clones dotfiles from remote repository
- Moves dotfiles to appropriate directories
- Full package database synchronization
- Install AUR helper [PARU](https://github.com/morganamilo/paru)
- Install and compare most recent list of packages ([PACKLIST](https://github.com/gsobell/dotfiles/tree/master/.packlist))
- Smart distro detection for package manager

### Future
- No additional features are planned at this time.

## Individualization
1. Make a [bare repo](https://odysee.com/@DistroTube:2/git-bare-repository-a-better-way-to) of your `$HOME` directory, including the settings stored in the `~/.config` folder. Be sure not to add any sensitive or personal information!
2. Optional: generate list of installed packages. For Arch-based distros, see [here](https://github.com/gsobell/dotfiles/blob/master/.packlist/README.md).
3. Push your repo to a remote origin. You can host with a service, or easily host it yourself, i.e on an Raspberry Pi.
4. Fork this repo on either [GitHub](https://github.com/gsobell/deployrable) or [Gitlab](https://gitlab.com/gsobell/deployrable).
5. Replace line 39 with the remote origin of your own dotfile repo.

Be sure to keep your backups up to date.

##
This software is provided "as is", without warranty of any kind. *Caveat emptor*.

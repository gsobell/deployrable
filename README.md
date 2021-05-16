# deployrable
Bash script for deploying dotfiles and selected packages primarily on live enviroments and fresh installs.

## Usage
You will be prompted for root if you choose to install PACKLIST.
```shell
curl https://raw.githubusercontent.com/gsobell/deployrable/home/deployrable.sh > deployrable.sh ;
chmod +x ./deployrable.sh ; ./deployrable.sh
```


It is not reccomended to ```curl | sh``` at this time, as it currently has some issues.

```shell
curl https://raw.githubusercontent.com/gsobell/deployrable/home/deployrable.sh | sh
```
## Features

### Current
- Clones dotfiles from repo
- Moves dotfiles to appropriate directories
- Install AUR helper PARU
- Install most recent list of packages (PACKLIST)

### Future
- Fix piping curl to sh
- Further interactivity
- Optional user supplied dotfile repo
- Use feh to set wallpaper
- Compatibility across non-pacman distros
- Make seperate PACKLIST option for Wayland
- Diff functionality for PACKLIST

##
This software is provided "as is", without warranty of any kind. *Caveat emptor*.

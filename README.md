# deployrable
Bash script for deploying dotfiles and selected packages primarily on live enviroments and fresh installs.

## Usage
Run either of the following in the home directory.
You will be prompted for root if you choose to install PACKLIST.

```shell
curl -s https://git.io/JssGR | sh
```

```shell
curl https://raw.githubusercontent.com/gsobell/deployrable/deployrable.sh | sh
```
## Features

### Current
- Clones dotfiles from repo
- Moves dotfiles to appropriate directories
- Install AUR helper PARU
- Install most recent list of packages (PACKLIST)

### Future
- Further interactivity
- Optional user supplied dotfile repo
- Use feh to set wallpaper
- Compatibility across non-pacman distros
- Pacstall option, when it becomes viable
- Make seperate PACKLIST option for Wayland
- Diff functionality for PACKLIST

##
This software is provided "as is", without warranty of any kind. *Caveat emptor*.

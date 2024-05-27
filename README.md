# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```
sudo apt install git
```

### Stow

```
sudo apt install stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
git clone git@github.com:kat-lego/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```

## References
- [Stow has forever changed the way I manage my dotfiles](https://www.youtube.com/watch?v=y6XCebnB9gs)

# TMUX config

Information about the tmux configuration

## Requirements

Ensure you have the following installed on your system

### Tmux

```
sudo apt install tmux
```

### Tmux plugin manager

Clone TPM

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
Make sure to install the configured plugins using `prefix + I`


# TMUXifier config

Information about the tmuxifier configuration


#!/bin/bash

dotfiles=~/dotfiles/

# Zsh Setup
if type "zsh" > /dev/null 2>&1; then
  ln -sf ${dotfiles}zsh/.zshenv ~/.zshenv
  ln -sf ${dotfiles}zsh/.zlogin ~/.zlogin
  ln -sf ${dotfiles}zsh/.zshrc ~/.zshrc
else
  echo "${0##*/}: Zsh isn't found." >&1
fi

# Nvim Setup
nvim_comf_path=~/.config/nvim/
if type "nvim" > /dev/null 2>&1; then
  mkdir -p ${nvim_comf_path}
  ln -sf ${dotfiles}vim/.vimrc ${nvim_comf_path}init.vim
else
  echo "${0##*/}: Neovim isn't found." >&1
fi

# Tmux Setup
if type "tmux" > /dev/null 2>&1; then
  ln -sf ${dotfiles}tmux/.tmux.conf ~/.tmux.conf
  if type "git" > /dev/null 2>&1; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
fi


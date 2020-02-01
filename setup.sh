#!/bin/zsh

ln -sf $PWD/gitignore ~/.gitignore
ln -sf $PWD/gitconfig ~/.gitconfig

ln -sf $PWD/zshrc ~/.zshrc

ln -sf $PWD/polipo ~/.polipo

mkdir -p ~/.config/nvim
ln -sf $PWD/nvim_init.vim ~/.config/nvim/init.vim
ln -sf $PWD/nvim_coc_settings.json ~/.config/nvim/coc-settings.json

mkdir -p ~/.hex
ln -sf $PWD/hex_config ~/.hex/hex.config

ln -sf $PWD/psqlrc ~/.psqlrc

ln -sf $PWD/spacemacs ~/.spacemacs

if [[ -a ../dotfiles-local/setup.sh ]] then
  cd ../dotfiles-local
  ./setup.sh
fi

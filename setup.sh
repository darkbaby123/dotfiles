#!/bin/zsh

ln -sf $PWD/gitignore ~/.gitignore
ln -sf $PWD/gitconfig ~/.gitconfig

ln -sf $PWD/zshrc ~/.zshrc

ln -sf $PWD/polipo ~/.polipo

ln -sf $PWD/npmrc ~/.npmrc

mkdir -p ~/.config/nvim
ln -sf $PWD/nvim_init.vim ~/.config/nvim/init.vim
mkdir -p ~/.config/coc/extensions
ln -sf $PWD/nvim_coc_settings.json ~/.config/nvim/coc-settings.json
ln -sf $PWD/nvim_coc_package.json ~/.config/coc/extensions/package.json

ln -sf $PWD/psqlrc ~/.psqlrc

ln -sf $PWD/spacemacs ~/.spacemacs

if [[ -a ../dotfiles-local/setup.sh ]] then
  cd ../dotfiles-local
  ./setup.sh
fi

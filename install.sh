#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"
DOTFILES_ROOT=$(pwd -P)

# homebrew
if test ! $(which brew)
then
  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi
fi
brew update
brew bundle

# oh-my-zsh
# if [ -z $ZSH ]
# then
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# fi

# copy symlinks
for dotfile in $(find . -maxdepth 1 \
    -not -path './.git'\
    -not -path './.gitignore'\
    -not -path './Brewfile'\
    -not -path './install.sh'\
    -not -path './README.md'\
    -not -path './.macos'\
    | cut -sd / -f 2- ) 
do
    rm -rf ~/$dotfile
    ln -s $DOTFILES_ROOT/$dotfile ~/$dotfile
    echo "${dotfile} successfully linked to ~/${dotfile}"
done

# setup macos
source .macos

# visual studio code extensions
# source ~/.zshrc
# code --install-extension HookyQR.beautify
# code --install-extension dbaeumer.vscode-eslint
# code --install-extension robertohuertasm.vscode-icons
# code --install-extension zhuangtongfa.Material-theme

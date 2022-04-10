#!/usr/bin/env bash

time_print=2
time_default=4
nameDotFiles=${PWD##*/}

spinner()
{
    local pid=$!
    local delay=0.3
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

sh=$(echo $SHELL)

if [[ `uname` == "Linux"   ]]
then
  printf "=========[Linux detected]========= \nConfiguring terminal, please wait ..." & sleep $time_print & spinner 
  printf "\n"

  printf "\n\n[+] Prepared dotfiles" & sleep $time_print & spinner 
  printf "\n"

  printf "\n\n[+] Configure bash to zsh... " & sleep $time_print & spinner  
  printf "\n"

  git config --global user.email "victorruiz524@gmail.com"
  git config --global user.name "Victor Ruiz"

  printf "\n\n[+] Creating Symlinks... " & sleep $time_print & spinner  
  printf "\n"
  ln -s -f ~/$nameDotFiles/zshrc ~/.zshrc
  ln -s -f ~/$nameDotFiles/.p10k.zsh ~/.p10k.zsh
  ln -s -f ~/$nameDotFiles/node-version ~/.node-version
  
  mkdir -p ~/.local/share/plugins/zsh-sudo
  wget -O ~/.local/share/plugins/zsh-sudo/sudo.plugin.zsh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

  printf "\n\n[+] Update respositories... " & sleep $time_print & spinner 
  
  printf "\n"
  sudo apt-get update && sudo apt-get -y upgrade

  printf "\n\n[+] Installing zsh... " & sleep $time_print & spinner 
  
  printf "\n"
  sudo apt -y install zsh

  printf "\n\n[+] Change sell to zsh... " & sleep $time_print & spinner 
  
  printf "\n"
  chsh -s $(which zsh)

  printf "\n\n[+] Installing brew...  " & sleep $time_print & spinner 
  printf "\n"
  echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> $HOME/.zprofile
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  sudo apt -y install build-essential

  printf "\n\n[+] Installing zInit... " & sleep $time_print & spinner 
  printf "\n"
  sh -c "$(curl -fsSL https://git.io/zinit-install)"

  printf "\n\n[+] Configure Utilities in ZSH... " & sleep $time_print & spinner 
  printf "\n"
  brew install gcc

  printf "\n\n[+] Installing bat... " & sleep $time_print & spinner 
  printf "\n"
  brew install bat

  printf "\n\n[+] Installing lsd... " & sleep $time_print & spinner 
  printf "\n" 
  brew install lsd

  printf "\n\n[+] Installing scrub... " & sleep $time_print & spinner 
  printf "\n"
  sudo apt install scrub

  printf "\n\nInstalling fzf... " & sleep $time_print & spinner 
  printf "\n"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  
  printf "\n\n[+] Installing Neovim...  " & sleep $time_print & spinner 
  printf "\n"
  brew install neovim

  printf "\n\n[+] Installing Utilities... " & sleep $time_print & spinner 
  printf "\n"
  sudo apt-get -y install unzip xclip

  printf "\n\n[+] Installing fnm... " & sleep $time_print & spinner 
  printf "\n"
  curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | bash
  export PATH=$HOME/.fnm:$PATH
  eval $(fnm env)
  
  printf "\n\n[+] Installing Nodejs and npm...  " & sleep $time_print & spinner 
  printf "\n"
  fnm install
  npm install -g npm@latest

  printf "\n\n[+] Installing Gitmoji... " & sleep $time_print & spinner 
  printf "\n"
  npm i -g gitmoji-cli 
  
  printf "\n\[+] Installing powerlevel10k...  " & sleep $time_print & spinner 
  printf "\n"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

  printf "\n\[+] Installing theme for neovim... " & sleep $time_print & spinner 
  printf "\n"
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
  nvim +'hi NormalFloat guibg=#1e222a' +PackerSync & 
  echo "=======================Process Complete!!! :) ======================="
fi
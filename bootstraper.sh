#!/bin/bash

echo "-------> Determining package manager"

DOCUMENTS_DIR="$HOME/Documents/repositories"

PACKAGE_MANAGER=""

if [ -x "$(command -v apt-get)" ] ; then
  PACKAGE_MANAGER="apt"
fi

if [ -x "$(command -v pacman)" ] ; then
  PACKAGE_MANAGER="pacman"
fi

if [ -z "$PACKAGE_MANAGER" ] ; then
  echo "Unable to find package manager"
  exit 1
fi

echo "         PACKAGE MANAGER: $PACKAGE_MANAGER"

echo "-------> Checking for sudo access"

if [ ! -x "$(command -v sudo)" ] ; then
  echo "sudo not found"
  exit 1
fi

echo "         Asking for sudo rights"

sudo -v || exit 1

echo "         OK"

echo "-------> Installing git"

if [ ! -x "$(command -v git)" ] ; then
  if [ "$PACKAGE_MANAGER" == "apt" ] ; then
    sudo apt-get install git
  else
    sudo pacman -S git
  fi
fi

if [ ! -x "$(command -v git)" ] ; then
  echo "Fail to install git"
  exit 1
fi

echo "-------> Creating base path"

mkdir -p $DOCUMENTS_DIR

echo "-------> Checking for ssh key"

if [ ! -f $HOME/.ssh/id_rsa ] ; then
  echo "         Unable to find ssh key"
  exit 1
fi

echo "-------> Cloning repo"

cd $DOCUMENTS_DIR

DOTFILES_HOME=$HOME/Documents/perso/dotfiles/

if [ ! -d $DOTFILES_HOME ] ; then
  git clone git@github.com:EtienneM/dotfiles.git
fi

if [ ! -d $DOTFILES_HOME ] ; then
  echo "         Fail to clone repo"
  exit 1
fi

echo "-------> Loading base libraries"

source $DOTFILES_HOME/libraries/bootstrap.sh

load $DOTFILES_HOME/libraries

success "Bootstraping complete"

info "Launching package script"

$DOTFILES_HOME/packages/installer.sh $PACKAGE_MANAGER

failFast $? "Fail to install packages"

info "Launching custom scripts"

$DOTFILES_HOME/custom/installer.sh

failFast $? "Fail to run custom scripts"

info "Launching dotfiles script"

$DOTFILES_HOME/dotfiles/installer.sh $HOME

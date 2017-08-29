#!/bin/bash

if [ -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ] ; then
  log "Zsh-Autosuggestions already installed. Skipping..."
  exit 0
fi

git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
failFast $? "Fail to install Zsh-Autosuggestions"

success "Zsh-Autosuggestions installed"

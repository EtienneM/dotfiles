#!/bin/bash

if [ -f $HOME/.zsh/completions/scalingo_complete.zsh ] ; then
  log "Scalingo CLI completion installed. Skipping..."
  exit 0
fi

curl
"https://raw.githubusercontent.com/Scalingo/cli/master/cmd/autocomplete/scripts/scalingo_complete.zsh" > ~/.zsh/completions/scalingo_complete.zsh
failFast $? "Fail to install Scalingo autocompletion"

success "Scalingo CLI autocompletion installed"


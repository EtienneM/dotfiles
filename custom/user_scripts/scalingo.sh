#!/bin/bash

if [ -d $HOME/Documents/Scalingo/tools-and-hacks/ ] ; then
  log "Scalingo base project installed. Skipping..."
  exit 0
fi

# TODO Do we have access already to variables defined in zshrc?
mkdir -p $HOME/Documents/Scalingo/
mkdir -p $HOME/Documents/Scalingo/golang/src/github.com/Scalingo

git clone git@github.com:Scalingo/tools-and-hacks.git $HOME/Documents/Scalingo/tools-and-hacks
failFast $? "Fail to install base scalingo repo"

success "Base Scalingo repo installed"

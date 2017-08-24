#!/bin/bash

if [ -d $HOME/.local/share/fonts ] ; then
  log "Patched fonts installed. Skipping..."
  exit 0
else
  git clone https://github.com/powerline/fonts.git --depth=1 /tmp/fonts
  /tmp/fonts/install.sh
  failFast $? "Fail to install patched fonts"
  rm -r /tmp/fonts
fi

success "Patched fonts installed"

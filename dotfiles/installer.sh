#!/bin/bash

# set -x
set -o nounset

if [ $# -gt 1 ]; then
  echo "Usage $0 [HOME_DIR]" >&2
  exit 1
fi

# HOME_DIR is either $1 or $HOME if $1 is undefined
HOME_DIR=${1-$HOME}

BASEDIR=$(cd $(dirname $0) && pwd)
cd $BASEDIR

source $BASEDIR/../libraries/bootstrap.sh
load $BASEDIR/../libraries

OLD_IFS=$IFS
IFS=$'\n'

info "Starting dotfiles synchronisation"

# Loop through every line in the `map` file, except empty and comment
for line in $( sed -e '/^$/d' -e '/^\#.*$/d' $BASEDIR/map) ; do
  src=$(echo $line | tr -s ' ' | cut -d' ' -f1)
  dst=$(echo $line | tr -s ' ' | cut -d' ' -f2)

  mkdir -p $HOME_DIR/$(dirname $dst)

  [ ! -e $HOME_DIR/$dst ] && ln -s $BASEDIR/$src $HOME_DIR/$dst
done

IFS=$OLD_IFS

success "Dotfiles synchronisation ended!"

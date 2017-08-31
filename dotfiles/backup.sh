#!/bin/bash
#
# Script de sauvegarde d'éléments qui ne peuvent pas être envoyé sur le dépôt Git
#

set -o nounset

CUR_DIR=$(cd $(dirname $0) && pwd)
cd $CUR_DIR

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 backup_directory" >&2
  exit 1
fi

if ! [[ -d "$1" ]]; then
  echo "$1 not a directory" >&2
  echo "Usage: $0 backup_directory" >&2
  exit 1
fi

mkdir $1/ssh
cp $HOME/.ssh/id_rsa* $1/ssh
cp $HOME/.ssh/config $1/ssh
cp $HOME/.ssh/known_hosts $1/ssh

mkdir $1/gnupg
cp -R $HOME/.gnupg $1/gnupg

mkdir $1/scalingo
cp -R $HOME/.scalingo/s3cfg_deployment_cache_production $HOME/.scalingo/vpn_* $1/scalingo

mkdir $1/zsh
cp $HOME/.zsh_history $1/zsh/zsh_history

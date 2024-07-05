#! /bin/bash

set -a
source .env
set +a
set -ue

GIT_SSH_URL=${GIT_SSH_URL:-git@github.com:cslant}

source ./setup/tips.sh
source ./setup/git.sh
source ./setup/functions.sh

case "$1" in
  welcome)
    welcome
    ;;

  help)
    usage
    ;;

  git_sync)
    git_sync "$2"
    ;;

  build)
    build
    ;;

  all)
    git_sync all
    build
    ;;

  *)
    usage
    exit 1
    ;;
esac

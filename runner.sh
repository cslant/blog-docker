#! /bin/bash

set -a
source .env
set +a
set -ue

GIT_SSH_URL=${GIT_SSH_URL:-git@github.com:cslant}

source ./setup/tips.sh
source ./setup/git.sh
source ./setup/resource.sh
source ./setup/functions.sh

case "$1" in
  welcome)
    welcome
    ;;

  help)
    usage
    ;;

  git_sync)
    # $2: all, admin, fe, api-package
    # $3: -f or --force
    git_sync "$2" "${3:-none}"
    ;;

  install)
    install
    ;;

  resource)
    resource
    ;;

  build)
    build
    ;;

  start)
    start
    ;;

  all)
    build
    git_sync all
    install
    resource
    start
    ;;

  *)
    usage
    exit 1
    ;;
esac

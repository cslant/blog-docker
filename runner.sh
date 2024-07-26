#! /bin/bash

# sync env file
if [ ! -f .env ]; then
  if ! command -v envsubst &> /dev/null; then
    cp .env.example .env
  else
    envsubst < .env.example > .env
  fi
fi

set -a
source .env
set +a
set -ue

source ./setup/variables.sh
source ./setup/tips.sh
source ./setup/git.sh
source ./setup/ssl.sh
source ./setup/resource.sh
source ./setup/functions.sh

case "$1" in
  welcome | w)
    welcome
    ;;

  help | h)
    usage
    ;;

  git_sync | gs)
    # $2: all, admin, fe, api-package
    # $3: -f or --force
    git_sync "$2" "${3:-none}"
    ;;

  install | i)
    install
    ;;

  resource | r)
    resource
    ;;

  ssl)
    ssl
    ;;

  build | b)
    build
    ;;

  start | s)
    start
    ;;

  start_all | sa)
    start_all
    ;;

  resource_database | rd)
    resource_database
    ;;

  all | a)
    ssl
    resource_database
    build
    git_sync all "${2:-none}"
    install
    resource
    start
    ;;

  *)
    usage
    exit 1
    ;;
esac

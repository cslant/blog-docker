#! /bin/bash

set -a
source .env
set +a
set -ue

source ./setup/tips.sh
source ./setup/functions.sh

case "$1" in
  welcome)
    welcome
    ;;

  help)
    usage
    ;;

  *)
    usage
    exit 1
    ;;
esac

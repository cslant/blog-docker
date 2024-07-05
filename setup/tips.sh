# shellcheck disable=SC2034
CURRENT_DIR=$(pwd)
SOURCE_DIR=$(readlink -f "$SOURCE_CODE_PATH")

welcome() {
  echo '
  ____ ____  _        _    _   _ _____   ____  _     ___   ____
 / ___/ ___|| |      / \  | \ | |_   _| | __ )| |   / _ \ / ___|
| |   \___ \| |     / _ \ |  \| | | |   |  _ \| |  | | | | |  _
| |___ ___) | |___ / ___ \| |\  | | |   | |_) | |__| |_| | |_| |
 \____|____/|_____/_/   \_\_| \_| |_|   |____/|_____\___/ \____|
  '
  echo ''
  echo '⚡ Welcome to the blog setup script ⚡'
  echo ''
  echo "- Current dir        : z "
  echo "- Source dir         : $SOURCE_DIR"
  echo ''
}

usage() {
  welcome
  echo "Usage: bash $0 [command] [args]"
  echo ''
  echo 'Commands:'
  echo '  welcome         Show welcome message'
  echo '  help            Show this help message'
  echo ''
  echo ''
  echo 'Example:'
  echo "  bash $0 help"
  echo ''
}

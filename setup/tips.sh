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
  echo "- Current dir        : $CURRENT_DIR"
  echo "- Source dir         : $SOURCE_DIR"
  echo ''
}

usage() {
  welcome
  echo "Usage: bash $0 [command] [args] [options]"
  echo ''
  echo 'Commands:'
  echo '  welcome         Show welcome message'
  echo '  help            Show this help message'
  echo '  git_sync        Sync git repositories'
  echo '  build           Build blog with Docker'
  echo '  start           Start blog with Docker'
  echo '  install         Install all blog dependencies'
  echo '  resource        Download blog resources'
  echo '  all             Sync git repositories and build blog'
  echo ''
  echo '------------------------------------------------------'
  echo ''
  echo 'Args for "git_sync":'
  echo '  admin           Sync blog-admin repository'
  echo '  fe              Sync blog-fe repository'
  echo '  api-package     Sync blog-api-package repository'
  echo '  core-package    Sync blog-core repository'
  echo '  all-packages    Sync all blog packages repositories'
  echo '  private-modules Sync blog-private-modules repository'
  echo '  all             Sync all related blog repositories'
  echo ''
  echo '  ∟ Options:'
  echo '    -f, --force   Force sync repositories (Remove existing directories and clone again)'
  echo ''
  echo '------------------------------------------------------'
  echo ''
  echo 'Example:'
  echo "  bash $0 help"
  echo "  bash $0 build"
  echo "  bash $0 git_sync admin"
  echo "  bash $0 git_sync all"
  echo "  bash $0 git_sync all -f"
  echo "  bash $0 install"
  echo "  bash $0 start"
  echo "  bash $0 all"
  echo ''
}

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
  echo '  welcome | w     Show welcome message'
  echo '  help | h        Show this help message'
  echo '  git_sync | gs   Sync blog repositories'
  echo '  build | b       Build blog with Docker'
  echo '  build_all | ba  Build blog with Docker (All services: nginx, postgres, php83, node, fe, elasticsearch and more tools)'
  echo '  network | n     Create Docker network'
  echo '  start | s       Start blog with Docker'
  echo '  start_all | sa  Start blog with Docker (All services: nginx, postgres, php83, node, fe, elasticsearch and more tools)'
  echo '  install | i     Install all blog dependencies'
  echo '  resource | r    Download blog resources'
  echo '  all | a         Sync git repositories and build blog'
  echo ''
  echo '------------------------------------------------------'
  echo ''
  echo 'Args for "git_sync":'
  echo '  admin               Sync blog-admin repository'
  echo '  fe                  Sync blog-fe repository'
  echo '  api-package         Sync blog-api-package repository'
  echo '  core-package        Sync blog-core repository'
  echo '  all-packages        Sync all blog packages repositories'
  echo '  private-modules     Sync blog-private-modules repository'
  echo '  all                 Sync all related blog repositories'
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
  echo "  bash $0 start_all"
  echo "  bash $0 all"
  echo ''
}

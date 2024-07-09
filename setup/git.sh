git_sync() {
  echo '📥 Syncing blog repositories...'
  FORCE=0
  if [ "$2" = '-f' ] || [ "$2" = '--force' ]; then
    FORCE=1
  fi

  case "$1" in
    admin)
      blog_admin_sync "$FORCE"
      ;;

    fe)
      blog_fe_sync "$FORCE"
      ;;

    api-package)
      blog_api_package_sync "$FORCE"
      ;;

    all)
      blog_admin_sync "$FORCE"
      blog_fe_sync "$FORCE"
      blog_api_package_sync "$FORCE"
      ;;

    *)
      usage
      exit 1
      ;;
  esac

  echo '✨ Syncing blog repositories done!'
  echo ''
}

blog_admin_sync() {
  REPO_NAME='blog-admin'

  cd "$SOURCE_DIR" || exit

  if [ "$1" = 1 ]; then
    echo "» Force syncing $REPO_NAME repository..."

    rm -rf "$REPO_NAME"
  else
    echo "» Syncing $REPO_NAME repository..."
  fi

  if [ -z "$(ls -A "$REPO_NAME")" ]; then
    echo "  ∟ Cloning $REPO_NAME repository..."
    git clone "$GIT_SSH_URL"/"$REPO_NAME".git
  else
    echo "  ∟ Pulling $REPO_NAME repository..."
    cd "$REPO_NAME" || exit

    git checkout main -f
    git pull
  fi
  echo ''
}

blog_fe_sync() {
  REPO_NAME='blog-fe'

  cd "$SOURCE_DIR" || exit

  if [ "$1" = 1 ]; then
    echo "» Force syncing $REPO_NAME repository..."

    rm -rf "$REPO_NAME"
  else
    echo "» Syncing $REPO_NAME repository..."
  fi

  if [ -z "$(ls -A "$REPO_NAME")" ]; then
    echo "  ∟ Cloning $REPO_NAME repository..."
    git clone "$GIT_SSH_URL"/"$REPO_NAME".git
  else
    echo "  ∟ Pulling $REPO_NAME repository..."
    cd "$REPO_NAME" || exit

    git checkout main -f
    git pull
  fi
  echo ''
}

blog_api_package_sync() {
  REPO_NAME='blog-api-package'

  cd "$SOURCE_DIR/blog-admin" || exit

  if [ ! -d "packages" ]; then
    mkdir packages
  fi

  cd packages || exit

  if [ "$1" = 1 ]; then
    echo "» Force syncing $REPO_NAME repository..."

    rm -rf "$REPO_NAME"
  else
    echo "» Syncing $REPO_NAME repository..."
  fi

  if [ -z "$(ls -A "$REPO_NAME")" ]; then
    echo "  ∟ Cloning $REPO_NAME repository..."
    git clone "$GIT_SSH_URL"/"$REPO_NAME".git
  else
    echo "  ∟ Pulling $REPO_NAME repository..."
    cd "$REPO_NAME" || exit

    git checkout main -f
    git pull
  fi
  echo ''
}

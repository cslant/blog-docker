git_sync() {
  echo '📥 Syncing blog repositories...'

  cd "$SOURCE_DIR" || exit
  echo ''

  case "$1" in
    admin)
      blog_admin_sync
      ;;

    fe)
      blog_fe_sync
      ;;

    api-package)
      blog_api_package_sync
      ;;

    all)
      blog_admin_sync
      blog_fe_sync
      blog_api_package_sync
      ;;
  esac

  echo '✨ Syncing blog repositories done!'
  echo ''
}

blog_admin_sync() {
  REPO_NAME='blog-admin'

  echo "» Syncing $REPO_NAME repository..."

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

  echo "» Syncing $REPO_NAME repository..."

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

  echo "» Syncing $REPO_NAME repository..."

  cd "$SOURCE_DIR/blog-admin" || exit

  if [ ! -d "packages" ]; then
    mkdir packages
  fi

  cd packages || exit

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

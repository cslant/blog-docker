network() {
  echo ''
  echo '🐳 Creating "cslant_blog" docker network 🌐'
  cd "$CURRENT_DIR" || exit

  BLOG_NETWORK=cslant_blog

  echo "◎ Creating network..."
  if [ -z "$(docker network ls -q -f name=$BLOG_NETWORK)" ]; then
    docker network create $BLOG_NETWORK
  else
    echo "  ∟ Network already exists"
  fi
}

build_handler() {
  echo '🐳 Building blog with Docker 🐳'

  network

  echo ''
  cd "$CURRENT_DIR" || exit
  echo "◎ Build blog with Docker..."
}

source_implement() {
  if [ "$1" == "install" ]; then
    COMPOSER_COMMAND="install"
  else
    COMPOSER_COMMAND="update"
  fi
  echo "  ∟ Blog Core Package..."
  docker compose run --rm -w /var/dev/blog-admin/packages/"${BLOG_PACKAGE_REPO_NAMES[1]}" php83 ash -l -c "\
    composer $COMPOSER_COMMAND; \
  "

  echo "  ∟ Blog API Package..."
  docker compose run --rm -w /var/dev/blog-admin/packages/"${BLOG_PACKAGE_REPO_NAMES[0]}" php83 ash -l -c "\
    composer $COMPOSER_COMMAND; \
  "

  echo "  ∟ Blog Admin..."
  docker compose run --rm -w /var/dev/blog-admin php83 ash -l -c "\
    composer $COMPOSER_COMMAND; \
  "

  echo "  ∟ Blog Fe..."
  docker compose run --rm -w /var/dev/blog-fe node ash -l -c "\
    yarn install; \
  "

  if [ "$FE_COMMAND" == "start" ]; then
    echo "  ∟ Building blog-fe..."
    docker compose run --rm -w /var/dev/blog-fe node ash -l -c "\
      yarn build; \
    "
  fi
}

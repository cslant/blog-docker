build() {
  echo '🐳 Building blog with Docker 🐳'
  echo ''
  cd "$CURRENT_DIR" || exit
  echo "◎ Build blog with Docker..."
  docker compose build
}

start() {
  echo '🚀 Starting blog with Docker 🚀'
  echo ''
  cd "$CURRENT_DIR" || exit
  echo "◎ Starting blog with Docker..."
  docker compose up -d nginx postgres php83 node fe
}

install() {
  echo '🚀 Installing blog with Docker 🚀'
  echo ''
  cd "$CURRENT_DIR" || exit
  echo "◎ Installing blog with Docker..."

  echo "  ∟ Blog Core Package..."
  docker compose run --rm -w /var/dev/blog-admin/packages/blog-core php83 ash -l -c "\
    composer install; \
  "

  echo "  ∟ Blog API Package..."
  docker compose run --rm -w /var/dev/blog-admin/packages/blog-api-package php83 ash -l -c "\
    composer install; \
  "

  echo "  ∟ Blog Admin..."
  docker compose run --rm -w /var/dev/blog-admin php83 ash -l -c "\
    composer install; \
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

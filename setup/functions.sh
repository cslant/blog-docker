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
  docker compose up -d nginx postgres php83
}

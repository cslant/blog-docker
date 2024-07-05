build() {
  echo '🐳 Building blog with Docker 🐳'
  echo ''
  cd "$CURRENT_DIR" || exit
  echo "◎ Build blog with Docker..."
  docker compose build
}

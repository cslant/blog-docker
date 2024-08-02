#!/bin/bash

build() {
  build_handler
  docker compose build
}

build_all() {
  build_handler
  docker compose -f docker-compose.yml -f docker-compose-tools.yml build
}

start() {
  echo '🚀 Starting blog with Docker 🚀'
  echo ''
  cd "$CURRENT_DIR" || exit
  echo "◎ Starting blog with Docker..."
  docker compose up -d nginx postgres php83 node fe elasticsearch
}

start_all() {
  echo '🚀 Starting blog with Docker 🚀'
  echo ''
  cd "$CURRENT_DIR" || exit
  echo "◎ Starting blog with Docker..."
  docker compose -f docker-compose.yml -f docker-compose-tools.yml up -d
}

install() {
  echo '🚀 Installing blog with Docker 🚀'
  echo ''
  cd "$CURRENT_DIR" || exit
  echo "◎ Installing blog with Docker..."

  source_implement "install"
}

update() {
  echo '🚀 Updating blog with Docker 🚀'
  echo ''
  cd "$CURRENT_DIR" || exit
  echo "◎ Updating blog with Docker..."

  source_implement "update"
}

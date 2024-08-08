#!/bin/bash

GIT_SSH_URL=${GIT_SSH_URL:-git@github.com:cslant}

# shellcheck disable=SC2034
GITHUB_TOKEN=${GIT_TOKEN:-ghp_1234567890}

# shellcheck disable=SC2034
CURRENT_DIR=$(pwd)

# shellcheck disable=SC2034
SOURCE_DIR=$(readlink -f "$SOURCE_CODE_PATH")

# shellcheck disable=SC2034
BLOG_PACKAGE_REPO_NAMES=(
  'blog-api-package'
  'blog-core'
)

# shellcheck disable=SC2034
DATABASE_FILE_NAME=${DATABASE_FILE_NAME:-cslant_blog}

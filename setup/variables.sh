GIT_SSH_URL=${GIT_SSH_URL:-git@github.com:cslant}
GITHUB_TOKEN=${GIT_TOKEN:-ghp_1234567890}
CURRENT_DIR=$(pwd)
SOURCE_DIR=$(readlink -f "$SOURCE_CODE_PATH")
BLOG_PACKAGE_REPO_NAMES=(
  'blog-api-package'
  'blog-core'
)

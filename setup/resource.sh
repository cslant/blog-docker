#! /bin/bash

resource() {
  resource_lang
  resource_public
  resource_database
}

resource_lang() {
  LANG_PATH="$SOURCE_CODE_PATH/blog-admin/lang"

  if [ ! -d "$LANG_PATH" ]; then
    mkdir -p "$LANG_PATH"
  fi

  curl \
    -H "Authorization: token $GITHUB_TOKEN" \
    -L https://raw.githubusercontent.com/cslant-community/blog-storage/docker/lang/Archive.zip \
    -o "$LANG_PATH/Archive.zip"

  unzip -o "$LANG_PATH/Archive.zip" -d "$LANG_PATH"
}

resource_public() {
  PUBLIC_PATH="$SOURCE_CODE_PATH/blog-admin/public"

  if [ ! -d "$PUBLIC_PATH" ]; then
    mkdir -p "$PUBLIC_PATH"
  fi

  curl \
    -H "Authorization: token $GITHUB_TOKEN" \
    -L https://raw.githubusercontent.com/cslant-community/blog-storage/docker/public/Archive.zip \
    -o "$PUBLIC_PATH/Archive.zip"

  unzip -o "$PUBLIC_PATH/Archive.zip" -d "$PUBLIC_PATH"
}

resource_database() {
  echo ''
  echo '» 🚀 Downloading database file... 🚀'
  DATABASE_PATH="$CURRENT_DIR/postgres/entry.d"

  if [ -f "$DATABASE_PATH/cslant_blog.sql" ]; then
    echo "» Database file already exists"
    echo ''
    return
  fi

  curl \
    -H "Authorization: token $GITHUB_TOKEN" \
    -L https://raw.githubusercontent.com/cslant-community/blog-storage/docker/database/postgres/cslant_blog.sql \
    -o "$DATABASE_PATH/cslant_blog.sql"
}

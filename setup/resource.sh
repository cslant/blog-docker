GITHUB_TOKEN=${GIT_TOKEN:-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}

resource() {
  resource_lang
  resource_public
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

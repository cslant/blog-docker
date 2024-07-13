DOMAINS=(
  "${BLOG_DOMAIN}"
  "${BLOG_API_DOMAIN}"
  "${BLOG_ADMIN_DOMAIN}"
)

if [ ! -d "$CURRENT_DIR/nginx/conf/customs" ]; then
  echo "◎ Folder could not be found, creating folder..."
  mkdir -p "$CURRENT_DIR"/nginx/conf/customs
fi

for domain in "${DOMAINS[@]}"; do
  if [ ! -f "$CURRENT_DIR/nginx/conf/customs/${domain}.conf" ]; then
    touch "$CURRENT_DIR/nginx/conf/customs/${domain}.conf"
    echo "Create successful file ${domain}.conf"
  fi
done

## Setup SSL for domain
ssl() {
  if [ "${IS_SSL}" == "true" ]; then
    echo ''
    echo '⚡ Setup SSL for domain ⚡'

    if ! command -v mkcert &> /dev/null; then
      echo "mkcert could not be found, installing..."
      sudo apt install libnss3-tools

      sudo wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 && \
      sudo mv mkcert-v1.4.3-linux-amd64 mkcert && \
      sudo chmod +x mkcert && \
      sudo cp mkcert /usr/local/bin/
    else
      echo "mkcert is already installed"
    fi

    if [ ! -d "nginx/server/certs" ]; then
      echo "Folder could not be found, creating folder..."
      mkdir -p nginx/server/certs
    fi

    create_certs

    cd "$SOURCE_DIR" || exit
    cd nginx/conf/customs || exit

    DOMAIN=(
      "${BLOG_DOMAIN}"
      "${BLOG_API_DOMAIN}"
      "${BLOG_ADMIN_DOMAIN}"
    )
     for domain in "${DOMAIN[@]}"; do
       SSL_CONTENT="ssl_certificate /var/www/certs/${domain}.local.pem;\nssl_certificate_key /var/www/certs/${domain}-key.pem;"
       if [ ! -s "${domain}.ssl.conf" ]; then
         echo -e "$SSL_CONTENT" | tee "${domain}.ssl.conf"
         echo "Create successful file ${domain}.ssl.conf"
       else
         echo -e "$SSL_CONTENT" | tee "${domain}.ssl.conf"
         echo "${domain}.ssl.conf already exists and update."
       fi
     done
  fi
}

function create_certs() {
  BLOG_CERTS_PATH="$CURRENT_DIR/nginx/server/certs/${BLOG_DOMAIN}.pem"
  if [ ! -f "$BLOG_CERTS_PATH" ]; then
      mkcert "${BLOG_DOMAIN}"
  else
    echo "Certificate for ${BLOG_DOMAIN} already exists."
  fi

  API_CERTS_PATH="$CURRENT_DIR/nginx/server/certs/${BLOG_API_DOMAIN}.pem"
  if [ ! -f "$API_CERTS_PATH" ]; then
    mkcert "${BLOG_API_DOMAIN}"
  else
    echo "Certificate for ${BLOG_API_DOMAIN} already exists."
  fi

  ADMIN_CERTS_PATH="$CURRENT_DIR/nginx/server/certs/${BLOG_ADMIN_DOMAIN}.pem"
  if [ ! -f "$ADMIN_CERTS_PATH" ]; then
     mkcert "${BLOG_ADMIN_DOMAIN}"
  else
     echo "Certificate for ${BLOG_ADMIN_DOMAIN} already exists."
  fi
}

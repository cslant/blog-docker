DOMAINS=(
  "${BLOG_DOMAIN}"
  "${BLOG_API_DOMAIN}"
  "${BLOG_ADMIN_DOMAIN}"
)

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

    generate_cert_files

    CUSTOMS_PATH="$CURRENT_DIR/nginx/conf/customs"
    for domain in "${DOMAINS[@]}"; do
      SSL_CONTENT="ssl_certificate /var/www/certs/${domain}.local.pem;\nssl_certificate_key /var/www/certs/${domain}-key.pem;"

      echo -e "$SSL_CONTENT" | tee "$CUSTOMS_PATH/${domain}.ssl.conf"
      echo "${domain}.ssl.conf setup successfully."
    done
  fi
}

function generate_cert_files() {
  CERTS_PATH="$CURRENT_DIR/nginx/server/certs"
  cd "$CERTS_PATH" || exit

  for domain in "${DOMAINS[@]}"; do
    create_cert_items "${domain}"
  done

  echo "Certificates generated successfully."
  cd "$CURRENT_DIR" || exit
}

function create_cert_items() {
  DOMAIN=$1
  CERTS_PATH="$CURRENT_DIR/nginx/server/certs"

  if [ ! -f "$CERTS_PATH/${DOMAIN}.pem" ]; then
    mkcert "${DOMAIN}"
  else
    echo "Certificate for ${DOMAIN} already exists."
  fi
}

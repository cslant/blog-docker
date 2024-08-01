#! /bin/bash

DOMAINS=(
  "${BLOG_DOMAIN}"
  "${BLOG_API_DOMAIN}"
  "${BLOG_ADMIN_DOMAIN}"
)

for domain in "${DOMAINS[@]}"; do
  if [ ! -f "$CURRENT_DIR/nginx/conf/customs/${domain}.ssl.conf" ]; then
    touch "$CURRENT_DIR/nginx/conf/customs/${domain}.ssl.conf"
    echo "Create successful file ${domain}.conf"
  fi
done

## Setup SSL for domain
ssl() {
  if [ "${IS_SSL}" == "true" ]; then
    echo ''
    echo '⚡ Setup SSL for domain ⚡'

    generate_cert_files

    CUSTOMS_PATH="$CURRENT_DIR/nginx/conf/customs"
    for domain in "${DOMAINS[@]}"; do
      SSL_CONTENT="listen 443 ssl http2;\nlisten [::]:443 ssl http2;\nssl_certificate /var/www/certs/${domain}.pem;\nssl_certificate_key /var/www/certs/${domain}-key.pem;"

      echo -e "$SSL_CONTENT" | tee "$CUSTOMS_PATH/${domain}.ssl.conf"
      echo "${domain}.ssl.conf setup successfully."
    done
  fi
}

function generate_cert_files() {
  for domain in "${DOMAINS[@]}"; do
    create_cert_items "${domain}"
  done

  echo "Certificates generated successfully."
}

function create_cert_items() {
  CERTS_PATH="$CURRENT_DIR/nginx/server/certs"

  if [ ! -f "$CERTS_PATH/${1}.pem" ]; then
    implement_cert "${1}" "$CERTS_PATH"
  else
    echo " ∟ Certificate for ${1} already exists."
  fi
}

function implement_cert() {
  DOMAIN=$1
  CERTS_PATH=$2

  if command -v mkcert &> /dev/null; then
    mkcert -install
    mkcert -cert-file "${CERTS_PATH}/${DOMAIN}.pem" -key-file "${CERTS_PATH}/${DOMAIN}-key.pem" "${DOMAIN}"
  elif command -v openssl &> /dev/null; then
    openssl req -x509 -out "${CERTS_PATH}/${DOMAIN}.pem" -keyout "${CERTS_PATH}/${DOMAIN}-key.pem" \
      -newkey rsa:2048 -nodes -sha256 \
      -subj '/CN=localhost' -extensions EXT -config <( \
       printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
  else
    echo "Please install mkcert or openssl to generate certificates."
    exit 1
  fi
}

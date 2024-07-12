ssl() {
  if [ ! -d "nginx/conf/customs" ]; then
    echo "Folder could not be found, creating folder..."
    mkdir -p nginx/conf/customs
  fi

  if [ "${IS_SSL}" == "true" ]; then
    echo ''
    echo '⚡ Setup SSL for domain ⚡'
  if ! command -v mkcert &> /dev/null
  then
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
  cd "$SOURCE_DIR" || exit
  cd nginx/server/certs || exit

  if [ ! -f "${BLOG_DOMAIN}.pem" ]; then
    mkcert ${BLOG_DOMAIN}
  else
    echo "Certificate for ${BLOG_DOMAIN} already exists."
  fi

  if [ ! -f "${BLOG_API_DOMAIN}.pem" ]; then
    mkcert ${BLOG_API_DOMAIN}
  else
    echo "Certificate for ${BLOG_API_DOMAIN} already exists."
  fi

  if [ ! -f "${BLOG_ADMIN_DOMAIN}.pem" ]; then
     mkcert ${BLOG_ADMIN_DOMAIN}
  else
     echo "Certificate for ${BLOG_ADMIN_DOMAIN} already exists."
  fi

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
  else
     cd nginx/conf/customs
     if [ ! -f "${BLOG_DOMAIN}.ssl.conf" ]; then
       touch "${BLOG_DOMAIN}.ssl.conf"
       echo "Create successful file ${BLOG_DOMAIN}.ssl.conf"
     else
       echo "" | tee "${BLOG_DOMAIN}.ssl.conf"
       echo "Remove text in file ${BLOG_DOMAIN}.ssl.conf"
     fi

     if [ ! -f "${BLOG_API_DOMAIN}.ssl.conf" ]; then
       touch "${BLOG_API_DOMAIN}.ssl.conf"
       echo "Create successful file ${BLOG_API_DOMAIN}.ssl.conf"
     else
       echo "" | tee "${BLOG_API_DOMAIN}.ssl.conf"
       echo "Remove text in file ${BLOG_API_DOMAIN}.ssl.conf"
     fi

     if [ ! -f "${BLOG_ADMIN_DOMAIN}.ssl.conf" ]; then
       touch "${BLOG_ADMIN_DOMAIN}.ssl.conf"
       echo "Create successful file ${BLOG_ADMIN_DOMAIN}.ssl.conf"
     else
       echo "" | tee "${BLOG_ADMIN_DOMAIN}.ssl.conf"
       echo "Remove text in file ${BLOG_ADMIN_DOMAIN}.ssl.conf"
     fi
  fi
}



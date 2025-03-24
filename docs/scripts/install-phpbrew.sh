#!/bin/bash

sudo add-apt-repository ppa:ondrej/php -y
sudo apt update -y

# https://github.com/phpbrew/phpbrew/wiki/Requirement
sudo apt install -y \
    build-essential \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libcurl4-gnutls-dev \
    libzip-dev \
    libssl-dev \
    libxml2-dev \
    libxslt-dev \
    libonig-dev \
    php8.1-cli \
    php8.1-bz2 \
    php8.1-xml \
    pkg-config

# https://phpbrew.github.io/phpbrew/
curl -L -O https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar
chmod +x phpbrew.phar
sudo mv phpbrew.phar /usr/local/bin/phpbrew

phpbrew init

LOAD_PHPENV="[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc"

if ! grep -q "$LOAD_PHPENV" "$HOME/.zshrc"; then
cat << EOF >> ~/.zshrc
$LOAD_PHPENV
EOF
fi

source ~/.phpbrew/bashrc

echo;
echo "phpbrew 설치 완료."
echo "아래와 같이 원하는 버전의 PHP를 설치하세요."
echo "ex) phpbrew install 8.3.19";

#!/bin/bash
# ubuntu18.04快速安装php7.2
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install -y php7.2
sudo apt-get install php7.2-enchant php7.2-mbstring
sudo apt-get install php7.2-snmp php7.2-bcmath php7.2-fpm
sudo apt-get install php7.2-mysql php7.2-soap php7.2-bz2
sudo apt-get install php7.2-gd php7.2-odbc php7.2-sqlite3
sudo apt-get install php7.2-cgi php7.2-gmp php7.2-opcache
sudo apt-get install php7.2-sybase php7.2-cli php7.2-imap
sudo apt-get install php7.2-pgsql php7.2-tidy php7.2-common
sudo apt-get install php7.2-interbase  php7.2-phpdbg php7.2-xml
sudo apt-get install php7.2-curl php7.2-intl php7.2-pspell php7.2-xmlrpc
sudo apt-get install php7.2-dba php7.2-json php7.2-readline php7.2-xsl
sudo apt-get install php7.2-dev php7.2-ldap php7.2-recode php7.2-zip

# 使用 php -v 查看版本即可

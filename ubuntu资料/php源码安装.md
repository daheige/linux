```
1.下载php7到/usr/local/src
cd /usr/local/src/
sudo mkdir /usr/local/php7
sudo wget http://cn2.php.net/distributions/php-7.1.11.tar.gz

2.安装相关依赖
sudo apt-get update
sudo apt-get install libxml2-dev libgtk2.0-dev
#安装gcc
sudo apt-get install build-essential
sudo apt-get install openssl 
sudo apt-get install libssl-dev libxslt-dev
sudo apt-get install make
sudo apt-get install curl
sudo apt-get install libcurl4-gnutls-dev
sudo apt-get install libjpeg-dev
sudo apt-get install libpng-dev
sudo apt-get install libmcrypt-dev
sudo apt-get install libreadline6 libreadline6-dev

3.解压
sudo tar zxvf php-7.1.11.tar.gz
cd php-7.1.11
sudo mkdir /usr/local/php7
新建php-fpm运行的用户
sudo useradd www-data                              //新建www-data用户

配置1：
sudo ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data --with-mysqli --with-pdo-mysql --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-inline-optimization --with-curl --enable-mbregex --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-pear --with-gettext --disable-fileinfo --enable-maintainer-zts --enable-json

另一种方式：
./configure --prefix=/usr/local/php7 \
 --enable-fpm --with-fpm-user=nobody --with-fpm-group=nobody \
 --with-libxml-dir --with-openssl --with-pcre-regex --with-pcre-jit --with-zlib \
 --with-curl --with-pcre-dir --with-gd --with-mcrypt \
 --with-gettext --with-mhash --with-jpeg-dir --with-mysqli --with-pdo-mysql \
 --with-tidy --with-iconv-dir --with-pear --with-freetype-dir \
 --enable-bcmath --enable-calendar --enable-exif --enable-zip \
 --enable-ftp --enable-gd-jis-conv --enable-gd-native-ttf \
 --enable-mbstring --enable-pcntl --enable-shmop --enable-soap --enable-sockets \
 --enable-sysvshm --enable-sysvsem --enable-sysvmsg --enable-json


配置2：针对64位操作系统
sudo ./configure --prefix=/usr/local/php7 --with-config-file-path=/usr/local/php7/etc --enable-fpm --enable-inline-optimization --disable-debug --disable-rpath --enable-shared --enable-opcache --with-mysqli --with-mysql-sock --enable-pdo --with-pdo-mysql --with-gettext --enable-mbstring --with-iconv --with-mcrypt --with-mhash --with-openssl --enable-bcmath --enable-soap --with-libxml-dir --enable-pcntl --enable-shmop --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-sockets --with-curl --with-zlib --enable-zip --with-readline --without-sqlite3 --without-pdo-sqlite --with-pear --with-libdir=/lib/x86_64-linux-gnu --with-gd --with-jpeg-dir=/usr/lib --with-png-dir --enable-gd-native-ttf --enable-xml

4.预处理通过之后就可以make编译
sudo make && sudo make install

5.配置php
编译安装成功后，一般可以在usr/local找到安装的php7
cd php-7.1.11
//php.ini
sudo cp php.ini-development /usr/local/php7/lib/php.ini

//php-fpm
sudo cp /usr/local/php7/etc/php-fpm.conf.default /usr/local/php7/etc/php-fpm.conf
sudo cp /usr/local/php7/etc/php-fpm.d/www.conf.default /usr/local/php7/etc/php-fpm.d/www.conf
sudo cp -R ./sapi/fpm/php-fpm /etc/init.d/php-fpm  或cp ./sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm

需要注意的是php7中www.conf这个配置文件配置phpfpm的端口号等信息，如果你修改默认的9000端口号需在这里改，再改nginx的配置

6.启动
//查看php版本
/usr/local/php7/bin/php -v
配置php-fpm可执行
sudo chmod +x /etc/init.d/php-fpm

//确定php-fpm配置文件的路径，执行
#ps -aux | grep php-fpm
在安装目录的etc下有个php-fpm.d目录(如/usr/local/php7/etc/php-fpm.d)，打开这个目录后，找到www.conf文件，修改该文件里：
user = www-data
group = www-data

#启动php-fpm
sudo /etc/init.d/php-fpm start
或 sudo service php-fpm start

//php-fpm 可用参数 start|stop|force-quit|restart|reload|status
```

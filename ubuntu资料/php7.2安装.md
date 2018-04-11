```
#ubuntu安装php7.2
#1. 下载php7.2
php_src=/usr/local/src
cd $php_src
sudo wget http://cn2.php.net/distributions/php-7.2.4.tar.gz

#2. 安装相关依赖
sudo apt-get update
sudo apt-get install gcc gcc-c++
sudo apt-get install libxml2-dev libgtk2.0-dev
sudo apt-get install build-essential
sudo apt-get install openssl openssh-server
sudo apt-get install libssl-dev libxslt-dev
sudo apt-get install make cmake
sudo apt-get install curl
sudo apt-get install libcurl4-gnutls-dev
sudo apt-get install libjpeg-dev
sudo apt-get install libpng-dev
sudo apt-get install libmcrypt-dev
sudo apt-get install libreadline6 libreadline6-dev
sudo apt-get install libtidy-dev
sudo apt-get install autoconf
sudo apt-get install libyaml-dev

#3. 解压php7.2
php_path=/usr/local/php7
sudo mkdir $php_path
sudo tar zxvf $php_src/php-7.2.4.tar.gz
cd $php_src/php-7.2.4
sudo ./configure --prefix=$php_path \
 --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data \
 --with-libxml-dir --with-openssl --with-pcre-regex --with-pcre-jit --with-zlib \
 --with-curl --with-pcre-dir --with-gd \
 --with-gettext --with-mhash --with-jpeg-dir --with-mysqli --with-pdo-mysql \
 --with-tidy --with-iconv-dir --with-pear --with-freetype-dir \
 --enable-bcmath --enable-calendar --enable-exif --enable-zip \
 --enable-ftp --enable-gd-jis-conv \
 --enable-mbstring --enable-pcntl --enable-shmop --enable-soap --enable-sockets \
 --enable-sysvshm --enable-sysvsem --enable-sysvmsg --enable-json

#4. 预处理通过之后就可以make编译
cd $php_src/php-7.2.4
sudo make && sudo make install
cd $php_src/php-7.2.4
sudo cp php.ini-development $php_path/lib/php.ini
sudo ln -s $php_path/lib/php.ini $php_path/etc/php.ini

#5. 设置php-fpm服务
sudo cp $php_path/etc/php-fpm.conf.default $php_path/etc/php-fpm.conf
sudo cp $php_path/etc/php-fpm.d/www.conf.default $php_path/etc/php-fpm.d/www.conf
sudo cp $php_src/php-7.2.4/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
# sudo cp $php_src/php-7.2.4/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
# 配置php-fpm可执行
sudo chmod +x /etc/init.d/php-fpm

#6. 启动
sudo /usr/local/php7/bin/php -v
sudo /etc/init.d/php-fpm start
echo "php-fpm start success!"

# 确定php-fpm配置文件的路径，执行
echo "ps php-fpm:"
sudo ps -aux | grep php-fpm | grep -v grep

#建立软连接
sudo ln -s $php_path/bin/php /usr/bin/php
sudo ln -s $php_path/bin/pecl /usr/bin/pecl
sudo ln -s $php_path/bin/phpize /usr/bin/phpize
sudo ln -s $php_path/bin/php-config /usr/bin/php-config

#配置phpize可执行
sudo chmod +x /usr/bin/phpize

#设置环境变量 需要root用户
# echo "export PHP_HOME=/usr/local/php7" >> /etc/profile
# echo "export PATH=\$PATH:\$PHP_HOME/bin" >> /etc/profile
# source /etc/profile

# php-fpm 可用参数 start|stop|force-quit|restart|reload|status
# sudo /etc/init.d/php-fpm restart

#安装redis,mongodb拓展
sudo pecl install redis
sudo vim $php_path/etc/php.ini
#在909行下面新增
extension=redis.so
:wq #保持退出

sudo pecl install mongodb
sudo vim $php_path/etc/php.ini
# 在910行下面新增
extension=mongodb.so

:wq  #保存退出
#可采用同样的方式用pecl可以安装yaml,swoole等其他拓展
#安装其他拓展，源码安装参考：https://github.com/daheige/linux/blob/master/php/php-mongo%E6%8B%93%E5%B1%95%E5%AE%89%E8%A3%85.txt
```

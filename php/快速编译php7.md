```
快速编译php7.1.0
第一步： 安装必要一些依赖 
yum install php-mcrypt libmcrypt libmcrypt-devel libxml2-devel openssl-devel libcurl-devel libjpeg.x86_64 libpng.x86_64 freetype.x86_64 libjpeg-devel.x86_64 libpng-devel.x86_64 freetype-devel.x86_64 libjpeg-turbo-devel libmcrypt-devel mysql-devel libtidy libtidy-devel -y

第二步： 下载php7源码包 (官网http://php.net/get/php-7.1.0.tar.gz/from/a/mirror)
wget http://cn2.php.net/distributions/php-7.1.0.tar.gz 
cd php-7.1.0 
第三步： 编译安装 
./configure --prefix=/usr/local/php7 \
 --enable-fpm --with-fpm-user=nobody --with-fpm-group=nobody \
 --with-libxml-dir --with-openssl --with-pcre-regex --with-pcre-jit --with-zlib \
 --with-curl --with-pcre-dir --with-gd --with-mcrypt \
 --with-gettext --with-mhash --with-jpeg-dir --with-mysqli --with-pdo-mysql \
 --with-tidy --with-iconv-dir --with-pear --with-freetype-dir \
 --enable-bcmath --enable-calendar --enable-exif --enable-zip \
 --enable-ftp --enable-gd-jis-conv --enable-gd-native-ttf \
 --enable-mbstring --enable-pcntl --enable-shmop --enable-soap --enable-sockets \
 --enable-sysvshm --enable-sysvsem --enable-sysvmsg

###编译#####
make 
make install

第四步： 配置php

cp php.ini-production /usr/local/php7/etc/php.ini

创建php7-fpm启动文件
cp sapi/fpm/init.d.php-fpm /etc/init.d/php7-fpm

赋予执行权限
chmod +x /etc/init.d/php7-fpm

设置php-fpm.conf 
cp /usr/local/php7/etc/php-fpm.conf.default /usr/local/php7/etc/php-fpm.conf

编辑/usr/local/php7/etc/php-fpm.conf的用户和用户组nginx

cp /usr/local/php7/etc/php-fpm.d/www.conf.default /usr/local/php7/etc/php-fpm.d/www.conf

vim /usr/local/php7/etc/php.ini

加入
zend_extension=/usr/local/php7/lib/php/extensions/no-debug-non-zts-20151012/opcache.so
不同的php7相关的目录不同，可以/usr/local/php7/lib/php/extensions/no-debug 按下tab键补全得到

启动

/etc/init.d/php7-fpm start

查看PHP版本

/usr/local/php7/bin/php -v

为了安全最好是去掉头信息 X-Powered-By: PHP/7..

则修改 php.ini 文件 设置 expose_php = Off

vim /usr/local/php7/etc/php.ini

找到 expose_php = On

改为 expose_php = Off
```

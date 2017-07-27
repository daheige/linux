关于nginx的fastcgi_pass设置问题
```
在配置nginx的时候，fastcgi_pass的配置问题，如下所示：

    location ~ \.php$ {
        root           /home/wwwroot;
        fastcgi_pass   127.0.0.1:9000;
        #fastcgi_pass  unix:/var/run/php-fpm/php-fpm.sock;
        #fastcgi_pass  unix:/tmp/php-cgi.sock;
        try_files $uri /index.php =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include        fastcgi_params;
    }
主要是关于fastcgi_pass参数，

#fastcgi_pass  unix:/var/run/php-fpm/php-fpm.sock;
#fastcgi_pass  unix:/tmp/php-cgi.sock;
这两种方式有什么区别，php7该用哪一个？
Nginx和PHP-FPM的进程间通信有两种方式,一种是TCP,一种是UNIX Domain Socket.
其中TCP是IP加端口,可以跨服务器.而UNIX Domain Socket不经过网络,只能用于Nginx跟PHP-FPM都在同一服务器的场景.用哪种取决于你的PHP-FPM配置:
方式1:
php-fpm.conf: listen = 127.0.0.1:9000
nginx.conf: fastcgi_pass 127.0.0.1:9000;
方式2:
php-fpm.conf: listen = /tmp/php-fpm.sock
nginx.conf: fastcgi_pass unix:/tmp/php-fpm.sock;
其中php-fpm.sock是一个文件,由php-fpm生成,类型是srw-rw----.

UNIX Domain Socket可用于两个没有亲缘关系的进程,是目前广泛使用的IPC机制,比如X Window服务器和GUI程序之间就是通过UNIX Domain Socket通讯的.这种通信方式是发生在系统内核里而不会在网络里传播.UNIX Domain Socket和长连接都能避免频繁创建TCP短连接而导致TIME_WAIT连接过多的问题.对于进程间通讯的两个程序,UNIX Domain Socket的流程不会走到TCP那层,直接以文件形式,以stream socket通讯.如果是TCP Socket,则需要走到IP层,对于非同一台服务器上,TCP Socket走的就更多了.

UNIX Domain Socket:
Nginx <=> socket <=> PHP-FPM
TCP Socket(本地回环):
Nginx <=> socket <=> TCP/IP <=> socket <=> PHP-FPM
TCP Socket(Nginx和PHP-FPM位于不同服务器):
Nginx <=> socket <=> TCP/IP <=> 物理层 <=> 路由器 <=> 物理层 <=> TCP/IP <=> socket <=> PHP-FPM

像mysql命令行客户端连接mysqld服务也类似有这两种方式:
使用Unix Socket连接(默认):
mysql -uroot -p --protocol=socket --socket=/tmp/mysql.sock
使用TCP连接:
mysql -uroot -p --protocol=tcp --host=127.0.0.1 --port=3306
```


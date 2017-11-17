```
######准备阶段########
  ubuntu平台安装相关依赖：
    安装gcc g++的依赖库
        sudo apt-get install build-essential libtool cmake make gcc
    安装 pcre依赖库（http://www.pcre.org/）
        sudo apt-get update
        sudo apt-get install libpcre3 libpcre3-dev

    安装 zlib依赖库（http://www.zlib.net）
        sudo apt-get install zlib1g-dev
    安装 ssl依赖库
        sudo apt-get install openssl
 centos平台安装相关依赖：
    安装make,gcc等
        yum -y update
        yum -y install make cmake gcc gcc-c++ automake autoconf libtool openssl openssh

####在线安装nginx#########
    Ubuntu：sudo apt-get install nginx
    CentOS:　sudo yum install nginx
###新建网站目录和日志目录####
    sudo mkdir /home/wwwroot
    sudo mkdir /home/wwwlogs
    sudo mkdir /home/wwwroot/heige.com  #demo
    
##########nginx.conf配置#################
user www-data;
worker_processes auto;
pid /run/nginx.pid;

events {
	worker_connections 768;
	# multi_accept on;
}

http {

	##
	# Basic Settings
	##

	sendfile on;
	tcp_nopush on;
	tcp_nodelay on;
	keepalive_timeout 65;
	types_hash_max_size 2048;
	# server_tokens off;

	# server_names_hash_bucket_size 64;
	# server_name_in_redirect off;

	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	##
	# SSL Settings
	##

	ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
	ssl_prefer_server_ciphers on;

	##
	# Logging Settings
	##

	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;

	##
	# Gzip Settings
	##

	gzip on;
	gzip_disable "msie6";

	# gzip_vary on;
	# gzip_proxied any;
	# gzip_comp_level 6;
	# gzip_buffers 16 8k;
	# gzip_http_version 1.1;
	# gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

	##
	# Virtual Host Configs
	##

	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/vhosts/*.conf;
}


#mail {
#	# See sample authentication script at:
#	# http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
# 
#	# auth_http localhost/auth.php;
#	# pop3_capabilities "TOP" "USER";
#	# imap_capabilities "IMAP4rev1" "UIDPLUS";
# 
#	server {
#		listen     localhost:110;
#		protocol   pop3;
#		proxy      on;
#	}
# 
#	server {
#		listen     localhost:143;
#		protocol   imap;
#		proxy      on;
#	}
#}

#########nginx service vhosts设置#########
server {
    listen      80;
    server_name heige.com;
    root        /home/wwwroot/heige.com/public;
    charset     utf-8;
    index       index.php index.html index.htm;

    try_files   $uri $uri/ @rewrite;

    location @rewrite {
        rewrite ^/(.*)$ /index.php?_url=/$1;
    }

    location ~ \.php$ {
        fastcgi_pass            127.0.0.1:9000;
        fastcgi_index           index.php;
        include                 fastcgi_params;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_param           SCRIPT_FILENAME    $document_root$fastcgi_script_name;
        fastcgi_param           PATH_INFO          $fastcgi_path_info;
        fastcgi_param           PATH_TRANSLATED    $document_root$fastcgi_path_info;
    }

    location ~ .*\.(gif|jpg|jpeg|png|bmp|swf|ico|js|css)$ {
        expires    30d;
        access_log off;
    }

    location ~ /\.ht {
        deny all;
    }

    access_log  logs/heige.com.log  main;
}

//自定义变量的配置
server
{
        listen 80;
        server_name heige.com  www.heige.com; #vhost domain
        index index.php index.html index.htm;
        set $root  /home/wwwroot/heige.com; #网站根目录设置
        set $path_info $fastcgi_path_info;
        root $root;
	charset     utf-8;

        #error_page   404   /404.html;

        try_files $uri =404;

        location / {
            root   $root;
        }

        #set php access
        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        location ~ \.php$ {
           fastcgi_index index.php;
           fastcgi_pass 127.0.0.1:9000;
           fastcgi_split_path_info ^(.+\.php)(/.+)$;
           fastcgi_param PATH_INFO $path_info;
           fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
           include fastcgi.conf;
        }

        location /nginx_status
        {
            access_log   off;
        }

        location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
        {
            expires      30d;
        }

        location ~ .*\.(js|css)?$
        {
            expires      12h;
        }

        location ~ /.well-known {
            allow all;
        }

        location ~ /\.
        {
            deny all;
        }

        access_log  /home/wwwlogs/heige.com-access.log;
}

```


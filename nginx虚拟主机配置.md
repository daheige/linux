常规的nginx server配置如下：
```
server
{
        listen 80;
        server_name heige.com  www.heige.com; #vhost domain
        index index.html index.htm index.php;
        root  /home/wwwroot/default;

        #error_page   404   /404.html;
        try_files $uri =404;
        #set php access
        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        location ~ \.php$ {
                include fastcgi_params;
                fastcgi_pass 127.0.0.1:9000;
                fastcgi_index index.php;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                include fastcgi.conf;
        }

        location /nginx_status
        {
            stub_status on;
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
``<br/>
配置好server后，在/etc/hosts添加
127.0.0.1 heige.com wwww.heige.com #可以配置不同的ip对应domain

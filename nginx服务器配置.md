```
server {
    listen 80;
    root /usr/share/nginx/html;
    index index.php index.html index.htm;
    server_name localhost;

    access_log /projects/wwwlogs/local-access.log;
    error_log /projects/wwwlogs/local-error.log;

    location / {
        index index.php index.html index.htm;
        try_files $uri $uri/ =404;
    }

    #error_page 404 /404.html;

    # redirect server error pages to the static page /50x.html
    #error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
    location ~ .*\.(gif|jpg|png|css|js)(.*) {
         expires 1d;
    }
}
```

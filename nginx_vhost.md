```
server {
        listen 80;
        index index.php index.html index.htm;
        root /web/hgtp.com/public;

        # Add index.php to the list if you are using PHP
        index index.html index.htm default.html;
        server_name hgtp.com *.hgtp.com;

        location / {
                try_files $uri $uri/ /index.php?$query_string;
        }

        # pass  FastCGI server listening on 127.0.0.1:9000
        location ~ \.php$ {
                fastcgi_pass 127.0.0.1:9000;
                fastcgi_index index.php;
                include fastcgi_params;

                fastcgi_split_path_info ^(.+\.php)(/.+)$;
                fastcgi_param SCRIPT_FILENAME    $document_root$fastcgi_script_name;
                fastcgi_param PATH_INFO          $fastcgi_path_info;
                fastcgi_param PATH_TRANSLATED    $document_root$fastcgi_path_info;
                fastcgi_param APP_ENV "TESTING";#TESTING;PRODUCTION;STAGING
        }

        location ~ /\.ht {
                deny all;
        }

        location ~ .*\.(xml|gif|jpg|jpeg|png|bmp|swf|woff|woff2|ttf|js|css)$ {
                expires 30d;
        }

        error_log /var/log/nginx/logs/hgtp-error.log;
        access_log /var/log/nginx/logs/hgtp-access.log;
}
```

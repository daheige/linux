```
server {
    listen 80;
    set $root_path "/web/hgnode";
    root $root_path;
    server_name www.hgnode.com hgnode.com;

    access_log /projects/wwwlogs/hgnode.com-access.log;
    error_log /projects/wwwlogs/hgnode.com-error.log;
    #error_page 404 /usr/share/nginx/html/40x.html;

    #error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }

    location @nodejs {
        proxy_http_version 1.1;         #http 版本
        proxy_set_header Host $host;    #为反向设置原请求头
        proxy_set_header X-Read-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Upgrade $http_upgrade; #设置WebSocket Upgrade
        proxy_set_header Connection "upgrade";
        proxy_set_header X-NginX-Proxy true;
        proxy_pass http://localhost:1337;
    }

    location / {
        try_files $uri @nodejs;
    }

    location ~ .*\.(gif|jpg|png|css|js|bmp|swf|ico)(.*) {
        root $root_path/public;
        access_log off;
        expires 30d;
    }
}
```

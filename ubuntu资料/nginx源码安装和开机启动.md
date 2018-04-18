# ubuntu 16.04 安装nginx和设置开机启动
# 准备
    安装gcc g++的依赖库

    sudo apt-get install build-essential
    sudo apt-get install libtool
    安装pcre依赖库（http://www.pcre.org/）
    sudo apt-get update
    sudo apt-get install libpcre3 libpcre3-dev
    安装zlib依赖库（http://www.zlib.net）
    sudo apt-get install zlib1g-dev
    安装SSL依赖库（16.04默认已经安装了）
    sudo apt-get install openssl
# 下载最新版本：
    wget http://nginx.org/download/nginx-1.13.12.tar.gz
# 解压：
    tar -zxvf nginx-1.13.12.tar.gz
    cd nginx-1.13.12
# 配置：
    sudo ./configure --prefix=/usr/local/nginx 
# 编译和安装
sudo make && sudo make install

# 启动：
    sudo /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
    注意：-c 指定配置文件的路径，不加的话，nginx会自动加载默认路径的配置文件，可以通过-h查看帮助命令。
# 查看进程：
    ps -ef | grep nginx
# 设置开机启动
    新增/etc/init.d/nginx文件 sudo vim /etc/init.d/nginx 添加如下内容:

    #! /bin/sh
    # Author: heige
    # nginx1.13启动脚步
    set -e
    PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
    DESC="nginx daemon"
    NAME=nginx
    DAEMON=/usr/local/nginx/sbin/$NAME
    SCRIPTNAME=/etc/init.d/$NAME


    # If the daemon file is not found, terminate the script.
    test -x $DAEMON || exit 0

    d_start() {
            $DAEMON || echo -n " already running"
    }

    d_stop() {
            $DAEMON -s quit || echo -n " not running"
    }

    d_reload() {
            $DAEMON -t || echo -n " could not reload"
    }

    case "$1" in
        start)
            echo -n "Starting $DESC: $NAME"
            d_start
            echo "."
            ;;
        stop)
            echo -n "Stopping $DESC: $NAME"
            d_stop
            echo "."
            ;;
        reload)
            echo -n "Reloading $DESC configuration..."
            d_reload
            echo "reloaded."
            ;;
        restart)
            echo -n "Restarting $DESC: $NAME"
            d_stop
            # Sleep for 1s before starting again, this should give the
            # Nginx daemon some time to perform a graceful stop.
            sleep 1
            d_start
            echo "."
            ;;
        *)
            echo "Usage: $SCRIPTNAME {start|stop|restart|reload}" >&2
            exit 3
            ;;
    esac

    exit 0

# 配置开机启动
    sudo chmod +x /etc/init.d/nginx 
    sudo sysv-rc-conf nginx on

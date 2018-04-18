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

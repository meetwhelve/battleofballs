#! /bin/bash


/etc/init.d/nginx start    # /etc/init.d/nginx -s reload

JS_PATH=/root/battleofballs/game/static/js/
JS_PATH_DIST=${JS_PATH}dist/
JS_PATH_SRC=${JS_PATH}src/
find $JS_PATH_SRC -type f -name '*.js' | sort | xargs cat | terser -c -m > ${JS_PATH_DIST}game.js
cd /root/battleofballs
echo yes | python3 manage.py collectstatic

redis-server /etc/redis/redis.conf

uwsgi --ini /root/battleofballs/scripts/uwsgi.ini

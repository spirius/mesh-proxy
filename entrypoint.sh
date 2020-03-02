#! /bin/bash

gofc -i n -o tpl nginx.tpl.conf > /usr/local/openresty/nginx/conf/nginx.conf

exec /usr/bin/openresty

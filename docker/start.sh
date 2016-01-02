#!/bin/bash

mkdir -p /var/www/blog/storage
cp -n /root/database.sqlite /var/www/blog/storage/

mkdir -p /var/www/blog/public
cp -nr /root/public/* /var/www/blog/public/

chown www-data:www-data -R /var/www/blog/
find /var/www/blog/ -type d -exec chmod 0750 '{}' ';'
find /var/www/blog/ -type f -exec chmod 0640 '{}' ';'
echo Environment prepared.

service nginx start
echo Web service started.

/usr/local/bin/dbpagerd
echo Application server started.

tail -f /var/log/nginx/error.log

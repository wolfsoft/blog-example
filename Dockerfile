# Blog Application Example Container
#
# This file is part of dbPager Server
#
# Copyright (c) 2015 Dennis Prochko <wolfsoft@mail.ru>
#
# dbPager Server is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation version 3.
#
# dbPager Server is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with dbPager Server; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, 
# Boston, MA  02110-1301  USA
#

FROM wolfsoft/dbpager:3.1.0

MAINTAINER Dennis Prochko <wolfsoft@mail.ru>

WORKDIR /var/www

# Copy application code
COPY ["nginx", "blog/nginx"]
COPY ["app", "blog/app"]
COPY ["public", "/root/public"]
COPY ["storage/*", "/root/"]
COPY ["docker/*", "/root/"]

# Install and configure
RUN export DEBIAN_FRONTEND=noninteractive \
	&& echo "deb http://httpredir.debian.org/debian unstable main contrib non-free" >> /etc/apt/sources.list \
	&& apt-get update \
	\
	&& apt-get -y -t unstable install letsencrypt \
	\
	&& apt-get -y install sudo openssl nginx-full \
	\
	&& openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048 \
	&& mv blog/app/config.production.dbpx blog/app/config.dbpx \
	&& cp -f blog/nginx/*.conf /etc/nginx/ \
	&& mkdir -p /var/cache/nginx \
	&& chown www-data:www-data /var/cache/nginx \
	&& chmod 0755 /var/cache/nginx \
	&& mkdir -p /etc/letsencrypt/live/localhost \
	&& cp -f blog/nginx/*.pem /etc/letsencrypt/live/localhost/ \
	&& cp -f blog/nginx/*.conf /etc/nginx/ \
	&& cp -f blog/nginx/htpasswd /etc/nginx/ \
	&& chown www-data:www-data /etc/nginx/*.conf \
	&& chown www-data:www-data /etc/nginx/htpasswd \
	&& chmod 0660 /etc/nginx/*.conf \
	&& chmod 0660 /etc/nginx/htpasswd \
	\
	&& sed -i "s;^bind = .*$;bind = /var/run/dbpagerd.sock;g" /usr/local/etc/dbpager/dbpager.conf \
	&& sed -i "s;^# user = .*$;user = www-data;g" /usr/local/etc/dbpager/dbpager.conf \
	&& sed -i "s;^# group = .*$;group = www-data;g" /usr/local/etc/dbpager/dbpager.conf \
	\
	&& chmod +x /root/start.sh \
	\
	&& mkdir -p /var/www/blog/storage \
	&& mkdir -p /var/www/blog/public \
	&& chown www-data:www-data -R /var/www/* \
	&& find /var/www/ -type d -exec chmod 0755 '{}' ';' \
	&& find /var/www/ -type f -exec chmod 0644 '{}' ';' \
	\
	&& find /usr/local/etc/dbpager/ ! -name 'dbp_sqlite.conf' ! -name 'dbpager.conf' -type f -delete \
	&& apt-get -y autoremove \
	&& apt-get -y clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tmp/* \
	&& rm -rf /var/tmp/*

VOLUME ["/var/www/blog/public", "/var/www/blog/storage", "/var/www/blog/app/local"]

EXPOSE 80 443

CMD /root/start.sh

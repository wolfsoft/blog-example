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
COPY ["public", "blog/public"]
COPY ["storage", "blog/storage"]

# Install and configure nginx
RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
	\
	&& apt-get -y install git \
	&& git clone https://github.com/letsencrypt/letsencrypt \
	&& letsencrypt/letsencrypt-auto --help \
	\
	&& apt-get -y install sudo openssl nginx-full \
	\
	&& openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048 \
	&& mv blog/app/config.production.dbpx blog/app/config.dbpx \
	&& cp -f blog/nginx/application.conf /etc/nginx/nginx.conf \
	\
	&& sed -i "s;^bind = .*$;bind = /var/run/dbpagerd.sock;g" /usr/local/etc/dbpager/dbpager.conf \
	&& sed -i "s;^# user = .*$;user = www-data;g" /usr/local/etc/dbpager/dbpager.conf \
	&& sed -i "s;^# group = .*$;group = www-data;g" /usr/local/etc/dbpager/dbpager.conf \
	\
	&& chown www-data:www-data -R /var/www/* \
	&& find /var/www/ -type d -exec chmod 0755 '{}' ';' \
	&& find /var/www/ -type f -exec chmod 0644 '{}' ';' \
	&& chown www-data:www-data /etc/nginx/nginx.conf \
	&& chmod 0640 /etc/nginx/nginx.conf \
	\
	&& find /usr/local/etc/dbpager/ ! -name 'dbp_sqlite.conf' ! -name 'dbp_xslt.conf' ! -name 'dbpager.conf' -type f -delete \
	&& apt-get -y purge git \
	&& apt-get -y autoremove \
	&& apt-get -y clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tmp/* \
	&& rm -rf /var/tmp/*

VOLUME ["/var/www/blog"]

EXPOSE 80 443

CMD /usr/local/bin/dbpagerd && /etc/init.d/nginx start && tail -f /var/log/nginx/error.log

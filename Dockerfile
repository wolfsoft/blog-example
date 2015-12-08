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
COPY ["app", "components", "public", "storage", "blog/"]

# Install and configure nginx
RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update && apt-get -y dist-upgrade \
	&& apt-get -y install nginx-full \
	\
	echo "\ndaemon off;" >> /etc/nginx/nginx.conf \
	\
	&& apt-get -y clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tmp/* \
	&& rm -rf /var/tmp/*

VOLUME ["/var/www/blog"]

EXPOSE 80 443

CMD /usr/local/bin/dbpagerd && nginx

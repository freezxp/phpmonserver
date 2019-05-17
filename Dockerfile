FROM eboraas/apache
MAINTAINER Ed Boraas <ed@boraas.ca>

RUN apt-get update && apt-get -y install php php-mysql curl wget php-curl && apt-get clean && rm -rf /var/lib/apt/lists/*
#RUN /usr/sbin/a2dismod 'mpm_*' && /usr/sbin/a2enmod mpm_prefork


CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
EXPOSE 443

#ENV VERSION 3.2.0
#ENV PHPMONITOR_URL https://sourceforge.net/projects/phpservermon/files/phpservermon/PHP%20Server%20Monitor%20v$VERSION/phpservermon-$VERSION.tar.gz/download

RUN set -x \
    && cd /var/www/html \
	&& rm -rf * \
	&& cd /tmp \
	#&& wget $PHPMONITOR_URL \ 
	&& wget https://sourceforge.net/projects/phpservermon/files/phpservermon/phpservermon-3.2.0.tar.gz \
	&& mv download phpmonitor.tar.gz \
	&& tar -xvf phpmonitor.tar.gz --strip-components=1 \
	&& cd phpservermon-3.2.0 \
	&& mv * /var/www/html \ 
	&& cd /var/www/html \
	&& touch config.php \
	&& chmod 0777 config.php

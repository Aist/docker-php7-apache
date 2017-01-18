FROM ubuntu:16.04
MAINTAINER Aist 

RUN apt-get update && apt-get install -y \
    apache2 \
    php7.0 php7.0-mysql php7.0-curl libapache2-mod-php php-bcmath php7.0-gd php7.0-intl php7.0-mbstring php-mhash php-openssl php7.0-xml php7.0-soap php7.0-xsl && \
    rm -rf /var/lib/apt/lists/* && \
    php7enmod mcrypt && \
    a2enmod php7.0

# Define working directory.
WORKDIR /

VOLUME "/var/www"
VOLUME "/tmp"

RUN echo '#!/bin/bash' > /init.sh 
RUN echo 'service apache2 start' >> /init.sh
RUN echo 'tail -f /var/log/apache2/access.log' >> /init.sh
RUN chmod +x /init.sh

# Define default command.
CMD ["/init.sh"]
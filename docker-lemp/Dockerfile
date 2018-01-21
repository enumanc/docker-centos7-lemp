FROM centos:centos7
MAINTAINER Emmanuel Chanson <emmanuelchanson@gmail.com>

# Install the Nginx.org CentOS repo.
ADD ./nginx.repo /etc/yum.repos.d/nginx.repo

# Install base stuff.
RUN yum -y install \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    https://rpms.remirepo.net/enterprise/remi-release-7.rpm \
&& rpm --import \
         /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 \
         /etc/pki/rpm-gpg/RPM-GPG-KEY-remi \
         /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 \
# Specify the version of PHP to install
&& yum-config-manager --enable remi,remi-php72 \
# Update existing things, then
&& yum -y update \
# install Nginx
&& yum -y install nginx \
# install supervisord
&& yum install -y supervisor \
# install PHP
&& yum -y install php \
    php-bcmath \
    php-common \
    php-devel \
    php-fpm \
    php-mbstring \
    php-mcrypt \
    php-pdo \
    php-pecl-memcached \
    php-pecl-mysql \
    php-xml \
    php7-pdo \
    php7-pdo_mysql \
    php7-mysqli \
    php7-gd \
    php7-openssl \
    php7-apcu \
    php7-gmagick \
    php7-xsl \
    php7-zip \
    php7-sockets \
    php7-iconv \
    php7-json \
    php7-intl \
    php7-memcached \
    php7-oauth \
    php7-imap \
    php7-gmp \
# Install PHP Composer
&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin \
# Remove the default configuration files.
&& rm /etc/php.ini /etc/php-fpm.conf /etc/php-fpm.d/www.conf

# Add custom NGINX configs:
#RUN sed -i '1i\daemon off;\' /etc/nginx/nginx.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf

# Add custom PHP configs:
COPY ./php.ini /etc/php.ini
COPY ./php-fpm.conf /etc/php-fpm.conf
COPY ./www.conf /etc/php-fpm.d/www.conf

# Clean up YUM when done.
RUN yum clean all

WORKDIR /opt
#COPY ./start-lemp.sh /opt/
COPY supervisord.conf /etc/supervisord.conf

EXPOSE 80 9000
ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

# Exmple command
# docker build -t element/centos-lemp-1 .
# docker run -d --rm -p 9000:9000 --name clemp -h cent-lemp element/centos-lemp:lep

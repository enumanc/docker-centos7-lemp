FROM centos:centos7

# Install some package resources
RUN yum -y install \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    https://rpms.remirepo.net/enterprise/remi-release-7.rpm \
#
 && rpm --import \
      /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 \
      /etc/pki/rpm-gpg/RPM-GPG-KEY-remi \
      /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 \
# Specify the version of PHP to install
 && yum-config-manager --enable remi,remi-php72 \
# Update existing things, then install PHP
 && yum -y update \
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
# Install PHP Composer
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin \
# Remove the default configuration files.
 && rm /etc/php.ini /etc/php-fpm.conf /etc/php-fpm.d/www.conf

# Add custom PHP configs.
ADD ./php.ini /etc/php.ini
ADD ./php-fpm.conf /etc/php-fpm.conf
ADD ./www.conf /etc/php-fpm.d/www.conf

EXPOSE 9000

# Run the PHP FPM server
CMD ["php-fpm", "-F"]

# Exmple command
# docker build -t element/centos-php:centos7-php72 .
# docker run -d --rm -p 9000:9000 --name php72-fpm -h php72-fpm element/centos-php:centos7-php72
# docker run -it --rm -p 9000:9000 --name php72-fpm -h php72-fpm element/centos-php:centos7-php72

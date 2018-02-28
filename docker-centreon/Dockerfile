FROM centos:centos7
MAINTAINER Emmanuel Chanson <emmanuel.chanson@element.nc>

# Update CentOS
RUN yum -y update
RUN yum -y install wget vim

# Install Centreon Repository
RUN yum -y install --nogpgcheck http://yum.centreon.com/standard/3.4/el7/stable/noarch/RPMS/centreon-release-3.4-4.el7.centos.noarch.rpm

# Install ssh
RUN yum -y install openssh-server openssh-client
RUN mkdir /var/run/sshd
RUN echo 'root:centreon' | chpasswd
RUN sed -i 's/^#PermitRootLogin/PermitRootLogin/g' /etc/ssh/sshd_config
#RUN service sshd restart

# Install centreon
RUN yum -y install --nogpgcheck MariaDB-server \
&& /etc/init.d/mysql start \
&& yum -y install \
	centreon \
	centreon-base-config-centreon-engine
	#centreon-installed \
	#centreon-clapi \
RUN echo -ne "[Service]\nLimitNOFILE=32000\n" | tee /etc/systemd/system/mariadb.service.d/limits.conf
RUN /etc/init.d/mysql stop

# Install Widgets
RUN yum -y install \
	centreon-widget-graph-monitoring \
	centreon-widget-host-monitoring \
	centreon-widget-service-monitoring \
	centreon-widget-hostgroup-monitoring \
	centreon-widget-servicegroup-monitoring
# Fix pass in db
#ADD scripts/cbmod.sql /tmp/cbmod.sql
#RUN /etc/init.d/mysql start && sleep 5 && mysql centreon < /tmp/cbmod.sql && /usr/bin/centreon -u admin -p centreon -a POLLERGENERATE -v 1 && /usr/bin/centreon -u admin -p centreon -a CFGMOVE -v 1 && /etc/init.d/mysql stop

# Set rights for setuid
RUN chown root:centreon-engine /usr/lib/nagios/plugins/check_icmp
RUN chmod -w /usr/lib/nagios/plugins/check_icmp
RUN chmod u+s /usr/lib/nagios/plugins/check_icmp

RUN sed -i 's/^;date.timezone =/date.timezone = Pacific\/Noumea/g' /etc/php.ini

# Install and configure supervisor
RUN yum -y install python-setuptools
RUN easy_install supervisor

# Todo better split file
ADD scripts/supervisord.conf /etc/supervisord.conf

# Expose port SSH and HTTP for the service
EXPOSE 22 80

CMD ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]

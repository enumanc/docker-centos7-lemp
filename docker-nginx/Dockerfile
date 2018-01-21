FROM centos:centos7
MAINTAINER Emmanuel Chanson <emmanuelchanson@gmail.com>

# Install the Nginx.org CentOS repo.
ADD ./nginx.repo /etc/yum.repos.d/nginx.repo

# Install base stuff.
RUN yum -y install nginx

# Clean up YUM when done.
RUN yum clean all

#COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf
RUN sed -i '1i\daemon off;\' /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx"]

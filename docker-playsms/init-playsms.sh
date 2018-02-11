#!/bin/bash
# - Install PLAYSMS 1.4 if not already installed
# - Run nginx in foreground
# - installer avant vim + wget
### GENERAL CONF ###############################################################

NGINX_DIR="/opt"
PLAYSMS_DIR="${NGINX_DIR}/playsms/web"
PLAYSMS_SOURCE_URL=${PLAYSMS_SOURCE_URL:-"https://github.com/antonraharja/playSMS/archive/1.4.tar.gz"}

### INSTALL PLAYSMS IF NOT INSTALLED ALREADY ######################################
mkdir -p $NGINX_DIR
if [ "$(ls -A $PLAYSMS_DIR)" ]; then
  echo "PLAYSMS is already installed at ${PLAYSMS_DIR}"
else
  echo '-----------> Install PLAYSMS'
  echo "Using ${PLAYSMS_SOURCE_URL}"
  wget -O /tmp/PLAYSMS.tar.gz $PLAYSMS_SOURCE_URL --no-check-certificate
  tar -C $NGINX_DIR -xzf /tmp/PLAYSMS.tar.gz
#  chown -R nginx $PLAYSMS_DIR
fi

FROM phusion/passenger-full:0.9.15

MAINTAINER Scott Blake "Scott.Blake@mail.wvu.edu"

# Base directory to install reposado. Useful when using a data-only container
ENV DOCKER_REPOSADO_INSTALL_PATH /home/app/reposado

# Run repo_sync every X hours
ENV DOCKER_REPOSADO_REPO_SYNC_INTERVAL 3

EXPOSE 8088

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN mkdir -p reposado/code \
  && mkdir -p reposado/html \
  && mkdir -p reposado/metadata \
  && curl -ksSL https://github.com/wdas/reposado/tarball/master | tar zx \
  && cp -rf wdas-reposado-*/code/* reposado/code/ \
  && rm -rf wdas-reposado-* \
  && rm -f master \
  && rm -f /etc/nginx/sites-enabled/default \
  && rm -f /etc/service/nginx/down \
  && apt-get -qq clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add files into container
COPY preferences.plist reposado/code/preferences.plist
COPY nginx.conf /etc/nginx/sites-enabled/reposado-nginx.conf
COPY reposado-start.sh /etc/my_init.d/reposado-start.sh

RUN chmod +x /etc/my_init.d/reposado-start.sh

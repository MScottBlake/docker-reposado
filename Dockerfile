FROM nginx:1.7

MAINTAINER Scott Blake "Scott.Blake@mail.wvu.edu"

ENV PATH /reposado/code:$PATH

EXPOSE 8088

RUN apt-get update \
  && apt-get install -y curl python \
  && apt-get clean \
  && mkdir -p /reposado/code /reposado/html /reposado/metadata \
  && curl -ksSL https://github.com/wdas/reposado/tarball/master | tar zx \
  && cp -rf wdas-reposado-*/code/* /reposado/code/ \
  && rm -f master /etc/nginx/sites-enabled/default /etc/service/nginx/down \
  && rm -rf wdas-reposado-* /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY preferences.plist /reposado/code/
COPY reposado.conf /etc/nginx/sites-enabled/

RUN chgrp -R www-data /reposado \
  && chmod -R g+wr /reposado

VOLUME /reposado/html
VOLUME /reposado/metadata

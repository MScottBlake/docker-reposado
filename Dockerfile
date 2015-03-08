FROM nginx:1.7

MAINTAINER Scott Blake "Scott.Blake@mail.wvu.edu"

ENV PATH /reposado/code:$PATH

RUN apt-get update \
  && apt-get install -y curl python \
  && apt-get clean \
  && mkdir -p /reposado/code /reposado/html /reposado/metadata \
  && curl -ksSL https://github.com/wdas/reposado/tarball/master | tar zx \
  && cp -rf wdas-reposado-*/code/* /reposado/code/ \
  && rm -f master /etc/nginx/sites-enabled/default /etc/service/nginx/down \
  && rm -rf wdas-reposado-* /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY preferences.plist /reposado/code/preferences.plist
COPY reposado.conf /etc/nginx/sites-enabled/reposado.conf

VOLUME /reposado/html
VOLUME /reposado/metadata

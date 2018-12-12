FROM nginx:stable

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

COPY nginx.conf /etc/nginx/
COPY preferences.plist /reposado/code/
COPY reposado.conf /etc/nginx/sites-enabled/

RUN chown -R www-data:www-data /reposado \
  && chmod -R ug+rws /reposado

VOLUME /reposado/html
VOLUME /reposado/metadata

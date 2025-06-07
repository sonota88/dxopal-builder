FROM ubuntu:22.04

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git \
    ruby \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN echo 'gem: --no-document' >> ~/.gemrc
RUN gem instal opal -v 1.2.0

WORKDIR /opt
RUN git clone \
  --branch v1.5.2-no-opal-parser \
  https://github.com/sonota88/dxopal.git

RUN mkdir /tmp/work
WORKDIR /tmp/work

# Common shared setup
FROM ruby:2.3.8
# Maintainer info
LABEL maintainer="Fabio Napoleoni <f.napoleoni@gmail.com>"
# Use unattended upgrades
ENV DEBIAN_FRONTEND=noninteractive
# Node version
ENV NODE_MAJOR=8
# Debian repository versions
ENV YARN_VERSION=1.19.0-1
# Startup files
ENV PORT 3000
# Update package cache and install https transport
RUN apt-get update -qq && apt-get -y install apt-transport-https curl
# Add google Chrome repository
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
# Packages repositories for yarn and node
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
# Setup node
RUN curl -sL https://deb.nodesource.com/setup_${NODE_MAJOR}.x | bash -
# Update package cache
RUN apt-get update -qq
# Install apt dependencies for typical rails environment
RUN apt-get install -y --no-install-recommends \
  build-essential \
  nodejs \
  yarn=${YARN_VERSION} \
  google-chrome-stable \
  curl libssl-dev \
  git \
  unzip \
  zlib1g-dev \
  libxslt-dev \
  mysql-client
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

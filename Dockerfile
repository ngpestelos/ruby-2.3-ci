FROM ruby:2.3.4
MAINTAINER Nestor G Pestelos Jr

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get -y install nodejs

RUN npm install -g yarn

RUN apt-get -y update

RUN apt-get -y install libgconf-2-4 libnss3-dev

RUN npm -g install chromedriver

RUN ln -sf /usr/lib/node_modules/chromedriver/lib/chromedriver/chromedriver /usr/local/bin/chromedriver

RUN apt-get -y install chromium

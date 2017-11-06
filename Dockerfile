FROM ruby:2.3.4
MAINTAINER Nestor G Pestelos Jr

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get -y install nodejs

RUN npm install -g yarn

RUN apt-get -y update

RUN apt-get -y install libgconf-2-4 libnss3-dev

RUN npm -g install chromedriver

RUN ln -sf /usr/lib/node_modules/chromedriver/lib/chromedriver/chromedriver /usr/local/bin/chromedriver

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

RUN apt-get update && apt-get -y install google-chrome-stable

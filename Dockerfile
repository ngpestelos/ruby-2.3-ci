FROM ruby:2.3.4
MAINTAINER Nestor G Pestelos Jr

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get -y install nodejs

RUN npm install -g yarn

ADD phantomjs-2.1.1-linux-x86_64.tar.bz2 /usr/local/share/

RUN cd /usr/local/share && tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 &\
  ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

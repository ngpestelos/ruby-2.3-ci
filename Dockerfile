FROM ruby:2.3.3
MAINTAINER Nestor G Pestelos Jr

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get -y install nodejs

RUN cd /usr/local/share && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 &&\
  tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 &&\
  ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

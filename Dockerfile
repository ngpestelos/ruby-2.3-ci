FROM debian:stable-slim
MAINTAINER Nestor G Pestelos Jr

# Based on https://github.com/yukinying/chrome-headless-browser-docker/blob/master/chrome/Dockerfile

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qqy \
  && apt-get -qqy install \
       dumb-init gnupg wget ca-certificates apt-transport-https \
       ttf-wqy-zenhei \
       curl \
       ruby-full \
       build-essential \
       zlib1g-dev \
       sudo \
       libpq-dev \
       ruby-mini-magick \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
  && apt-get -y install nodejs \
  && npm install -g yarn \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install google-chrome-unstable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN useradd ruby --shell /bin/bash --create-home \
  && usermod -a -G sudo ruby \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'ruby:nopassword' | chpasswd

RUN mkdir /data && chown -R ruby:ruby /data

RUN chown -R ruby:ruby /var/lib/gems \
  && chown -R ruby:ruby /usr/local/bin

RUN echo 'gem: --no-rdoc --no-ri' > /home/ruby/.gemrc

RUN su ruby -c "gem install bundler" \
  && su ruby -c "gem install rails"

ARG CHROME_DRIVER_VERSION=2.33
RUN wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

RUN ln -sf /usr/bin/google-chrome /usr/bin/chrome

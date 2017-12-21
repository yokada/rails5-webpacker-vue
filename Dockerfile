FROM ruby:2.4.3

ENV APP /app
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs npm apt-transport-https && \
    npm install -g n && \
    n stable && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    mkdir $APP

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && \
    apt-get install -y yarn

WORKDIR $APP
COPY Gemfile* $APP/
RUN bundle install

COPY . $APP

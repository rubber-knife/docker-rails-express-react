FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /rails

COPY Gemfile ./
COPY Gemfile.lock ./

RUN bundle install

COPY . .

FROM ruby:3.0.0
ENV INSTALL_PATH /opt/app

RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

COPY . .

RUN gem install bundler
RUN bundle install

CMD bundle exec ruby lib/dndbot.rb

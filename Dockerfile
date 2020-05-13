FROM ruby:2.6.3
# RAILS_ENV と RAILS_MASTER_KEY をあと差しできるようにしています 
ARG RAILS_ENV
ARG RAILS_MASTER_KEY
ENV APP_ROOT /app
# あと差しした RAILS_ENV と RAILS_MASTER_KEY を環境変数に設定します 
ENV RAILS_ENV ${RAILS_ENV}
ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}
WORKDIR $APP_ROOT

# まずは Gemfile のみを ADD し bundle install を行います 
ADD Gemfile $APP_ROOT
# CMD ["pwd"]
ADD Gemfile.lock $APP_ROOT
RUN gem install bundler
RUN \
    bundle install && \
    rm -rf ~/.gem
ADD . $APP_ROOT
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn && apt-get install -y vim
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
    apt-get install nodejs
# RAILS_ENV が production のとき assets:precompile を実行するようにしています
RUN if [ "${RAILS_ENV}" = "production" ]; then bundle exec rails assets:precompile; else export RAILS_ENV=development; fi
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
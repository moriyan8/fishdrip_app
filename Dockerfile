# Dockerfile
# syntax = docker/dockerfile:1

# Make sure this matches .ruby-version
ARG RUBY_VERSION=3.2.8
FROM ruby:$RUBY_VERSION-slim AS base

WORKDIR /app

# Node.js と Yarn を公式スクリプトでインストール
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential \
      libpq-dev \
      libyaml-dev \
      curl \
      libjemalloc2 \
      libvips \
      postgresql-client \
      git \
      gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      nodejs \
      yarn \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

# Bundlerバージョンを2.5.22に指定
RUN gem install bundler -v 2.5.22

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test"

# Copy Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# package.json / yarn.lock を先にコピーして依存解決（キャッシュ最適化）
COPY package.json yarn.lock ./
RUN yarn install

# Copy app source
COPY . .

# Precompile assets (SECRET_KEY_BASEはRenderの環境変数でセット)
RUN SECRET_KEY_BASE=DUMMY ./bin/rails assets:precompile

RUN apt-get update && \
    apt-get install -y imagemagick webp

# 非rootユーザーで実行（セキュリティ向上）
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails /app
USER rails

EXPOSE 3000

# Renderで起動時にマイグレーションしてからサーバ起動
CMD ["sh", "-c", "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0"]

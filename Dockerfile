FROM ruby:3.0.4-alpine

ENV BUNDLER_VERSION=2.3.16

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \ 
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      postgresql-dev \
      tzdata \
      yarn 

ENV WORK_ROOT /var
ENV RAILS_ROOT $WORK_ROOT/www/
ENV GEM_HOME $WORK_ROOT/bundle
ENV BUNDLE_BIN $GEM_HOME/gems/bin
ENV PATH $GEM_HOME/bin:$BUNDLE_BIN:$PATH

RUN gem install bundler -v 2.3.16

RUN mkdir -p $RAILS_ROOT
RUN bundle config — path=$GEM_HOME

WORKDIR $RAILS_ROOT

COPY Gemfile ./
COPY Gemfile.lock ./

RUN bundle check || bundle install

COPY . $RAILS_ROOT

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
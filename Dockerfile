FROM ruby:3.3.6-alpine

RUN apk update && apk upgrade \
&& apk add --update --no-cache \
build-base curl-dev git postgresql-dev \
yaml-dev zlib-dev nodejs yarn tzdata gcompat glib nss libxcb libgcc chromium

WORKDIR /app

COPY ./Gemfile ./

COPY ./Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle install || bundle check

COPY ./ ./

ENTRYPOINT ["sh","./entrypoint.sh"]

EXPOSE 3000
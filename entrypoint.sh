#!/bin/bash

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

ENV=`rails r "puts Rails.env"`
if [ $ENV != "production" ]; then
 bundle exec rails db:drop
 bundle exec rails db:create
fi

bundle exec rails db:migrate

if [ $ENV != "production" ]; then
 bundle exec rails db:seed
fi

bundle exec rails s -b 0.0.0.0

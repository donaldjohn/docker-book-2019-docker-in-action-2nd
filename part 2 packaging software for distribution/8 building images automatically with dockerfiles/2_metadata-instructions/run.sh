#!/bin/bash
set -x # echo on

docker image build -t dockerinaction/mailer-base:0.6 -f mailer-base.df .

# docker inspect dockerinaction/mailer-base:0.6 > image-inspect.json
docker inspect dockerinaction/mailer-base:0.6

docker image build -t dockerinaction/mailer-logging -f mailer-logging.df .
docker run -d --name logging-mailer dockerinaction/mailer-logging

docker image build -t dockerinaction/mailer-live -f mailer-live.df .
docker run -d --name live-mailer dockerinaction/mailer-live

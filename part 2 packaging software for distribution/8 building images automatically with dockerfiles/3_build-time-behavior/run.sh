#!/bin/bash
set -x # echo on

docker image build -t dockerinaction/ch8_onbuild -f base.df .

docker image build -t dockerinaction/ch8_onbuild_down -f downstream.df .

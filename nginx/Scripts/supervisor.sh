#! /usr/bin/env bash

apt-get update

apt-get install --no-install-recommends --no-install-suggests -y \
supervisor

apt-get -y autoremove
apt-get autoclean
apt-get clean

rm -rf /var/lib/apt/lists/*

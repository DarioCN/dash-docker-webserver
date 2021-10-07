#! /usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

apt-get -y update
apt-get -y upgrade

apt-get -y autoremove
apt-get autoclean
apt-get clean

rm -rf /var/lib/apt/lists/*

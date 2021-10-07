#! /usr/bin/env bash

apt-get update

apt-get install --no-install-recommends --no-install-suggests -y \
build-essential

pip install --no-cache-dir --upgrade uwsgi
find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

apt-get remove --purge --auto-remove -y \
build-essential

apt-get autoclean
apt-get clean

rm -rf /var/lib/apt/lists/*

#! /usr/bin/env bash

apt-get update

apt-get install --no-install-recommends --no-install-suggests -y \
build-essential

pip install --no-cache-dir --upgrade meinheld

# pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U || true

find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

apt-get remove --purge --auto-remove -y \
build-essential

apt-get autoclean
apt-get clean

rm -rf /var/lib/apt/lists/*

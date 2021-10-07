#! /usr/bin/env bash

pip install --no-cache-dir --upgrade meinheld

pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U || true

find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

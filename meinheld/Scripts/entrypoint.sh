#! /usr/bin/env bash

set -e

export APP_MODULE="main:app"
export GUNICORN_CONF=/gunicorn.py
export PYTHONPATH=/app

exec "$@"

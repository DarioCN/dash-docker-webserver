import json
import multiprocessing
import os

# Gunicorn config variables
loglevel = "info"
workers = 2 * multiprocessing.cpu_count()
bind = "0.0.0.0:8050"
keepalive = 120
errorlog = "-"

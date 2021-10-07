import json
import multiprocessing
import os

# Gunicorn config variables
loglevel = "info"
workers = workers_per_core * cores
bind = "0.0.0.0:8050"
keepalive = 120
errorlog = "-"

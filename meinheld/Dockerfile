# FROM python:slim-buster
FROM python:slim

# Actualizar Debian
COPY Scripts/debian.sh /
RUN bash /debian.sh \
    && rm /debian.sh

# Instalar Meinheld
COPY Scripts/meinheld.sh /
RUN bash /meinheld.sh \
    && rm /meinheld.sh

# Instalar Gunicorn
COPY Scripts/gunicorn.sh /
RUN bash /gunicorn.sh \
    && rm /gunicorn.sh
COPY Configs/gunicorn.py /gunicorn.py

# Instalar Dash
COPY Scripts/dash.sh /
RUN bash /dash.sh \
    && rm /dash.sh

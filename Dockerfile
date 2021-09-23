FROM python:slim-buster

# Actualizar Debian
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y autoremove \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalar NGINX
COPY nginx.sh /
RUN bash /nginx.sh \
    && rm /nginx.sh \
    && rm /etc/nginx/conf.d/default.conf

# Instalar uWSGI
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y\
    build-essential \
    && pip install --no-cache-dir --upgrade uwsgi \
    && find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf \
    && apt-get remove --purge --auto-remove -y \
    build-essential \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY uwsgi.ini /etc/uwsgi/

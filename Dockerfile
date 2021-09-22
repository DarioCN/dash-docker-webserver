FROM python:slim-buster

# Instalar NGINX
COPY nginx.sh /
RUN bash /nginx.sh \
    && rm /nginx.sh \
    && rm /etc/nginx/conf.d/default.conf

# Instalar uWSGI
RUN pip install --no-cache-dir --upgrade setuptools uwsgi

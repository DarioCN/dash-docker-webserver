FROM python:slim-buster

# Actualizar Debian
COPY debian.sh /
RUN bash /debian.sh \
    && rm /debian.sh

# Instalar NGINX
COPY nginx.sh /
RUN bash /nginx.sh \
    && rm /nginx.sh \
    && rm /etc/nginx/conf.d/default.conf

# Instalar uWSGI
COPY uwsgi.sh /
RUN bash /uwsgi.sh \
    && rm /uwsgi.sh
COPY uwsgi.ini /etc/uwsgi/

# Instalar Supervisor
COPY supervisor.sh /
RUN bash /supervisor.sh \
    && rm /supervisor.sh
COPY supervisor.conf /etc/supervisor/conf.d/supervisord.conf
COPY stop-supervisor.sh /etc/supervisor/stop-supervisor.sh
RUN chmod +x /etc/supervisor/stop-supervisor.sh

# Instalar Dash
RUN pip install --no-cache-dir --upgrade dash \
    && pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U || true \
    && find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

# Establecer entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 8050

CMD ["/usr/bin/supervisord"]

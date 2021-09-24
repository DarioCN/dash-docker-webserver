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
COPY dash.sh /
RUN bash /dash.sh \
    && rm /dash.sh

# Establecer entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

# Exponer puerto y lanzar servidor
EXPOSE 8050
CMD ["/usr/bin/supervisord"]

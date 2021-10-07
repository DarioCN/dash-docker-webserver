# FROM python:slim-buster
FROM python:slim

# Actualizar Debian
COPY Scripts/debian.sh /
RUN bash /debian.sh \
    && rm /debian.sh

# Instalar NGINX
COPY Scripts/nginx.sh /
RUN bash /nginx.sh \
    && rm /nginx.sh \
    && rm /etc/nginx/conf.d/default.conf

# Instalar uWSGI
COPY Scripts/uwsgi.sh /
RUN bash /uwsgi.sh \
    && rm /uwsgi.sh
COPY Configs/uwsgi.ini /etc/uwsgi/

# Instalar Supervisor
COPY Scripts/supervisor.sh /
RUN bash /supervisor.sh \
    && rm /supervisor.sh
COPY Configs/supervisor.conf /etc/supervisor/conf.d/supervisord.conf
COPY Scripts/stop-supervisor.sh /etc/supervisor/stop-supervisor.sh
RUN chmod +x /etc/supervisor/stop-supervisor.sh

# Instalar Dash
COPY Scripts/dash.sh /
RUN bash /dash.sh \
    && rm /dash.sh

# Establecer entrypoint
COPY Scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

# Exponer puerto y lanzar servidor
EXPOSE 8050
CMD ["/usr/bin/supervisord"]

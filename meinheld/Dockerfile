# FROM python:slim-buster
FROM python:3.9-slim

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

# Establecer entrypoint
COPY Scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

# Exponer puerto y lanzar servidor
EXPOSE 8050
CMD ["gunicorn -k egg:meinheld#gunicorn_worker -c "$GUNICORN_CONF" "$APP_MODULE""]

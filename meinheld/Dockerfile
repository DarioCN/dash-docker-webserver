# FROM python:slim-buster
FROM python:slim

# Actualizar Debian
COPY Scripts/debian.sh /
RUN bash /debian.sh \
    && rm /debian.sh

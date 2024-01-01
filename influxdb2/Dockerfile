# syntax=docker/dockerfile:1
FROM influxdb:latest
COPY ./data /var/lib/influxdb2
COPY ./scripts/* /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/*.sh
EXPOSE 8086

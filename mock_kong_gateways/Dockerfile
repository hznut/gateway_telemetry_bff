# syntax=docker/dockerfile:1
FROM kong:2.7.1-alpine
COPY ./kong.prom.yml /kong/declarative/kong.yml
ENV KONG_DATABASE="off"
ENV KONG_DECLARATIVE_CONFIG="/kong/declarative/kong.yml"
ENV KONG_PROXY_ACCESS_LOG="/dev/stdout"
ENV KONG_ADMIN_ACCESS_LOG="/dev/stdout"
ENV KONG_PROXY_ERROR_LOG="/dev/stderr"
ENV KONG_ADMIN_ERROR_LOG="/dev/stderr"
ENV KONG_ADMIN_LISTEN="0.0.0.0:8001, 0.0.0.0:8444 ssl"
EXPOSE 8000
EXPOSE 8001
EXPOSE 8443
EXPOSE 8444

# syntax=docker/dockerfile:1
FROM prom/prometheus
COPY ./prometheus.yml /etc/prometheus/prometheus.yml
COPY ./prometheus_rules.yml /etc/prometheus/prometheus_rules.yml
EXPOSE 9090
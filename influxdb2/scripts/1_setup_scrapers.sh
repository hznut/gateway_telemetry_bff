#!/bin/bash
set -e

influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f /docker-entrypoint-initdb.d/scrape_kong_prometheus_metrics.flux

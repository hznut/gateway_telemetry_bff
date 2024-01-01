#!/bin/bash
set -e

influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n kong_prometheus_metrics_normalized_diffed
influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f /docker-entrypoint-initdb.d/normalize_diff_counter_data.flux

#!/bin/bash
set -e

influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_ingress_per_svc_per_route_per_1m
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_egress_per_svc_per_route_per_1m
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_ingress_per_svc_per_route_per_5m
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_egress_per_svc_per_route_per_5m
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_ingress_per_svc_per_route_per_1h
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_egress_per_svc_per_route_per_1h

influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_ingress_per_svc_per_1m
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_egress_per_svc_per_1m
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_ingress_per_svc_per_5m
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_egress_per_svc_per_5m
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_ingress_per_svc_per_1h
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_egress_per_svc_per_1h

influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_ingress_per_1m
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_egress_per_1m
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_ingress_per_5m
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_egress_per_5m
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_ingress_per_1h
influx bucket create --org $DOCKER_INFLUXDB_INIT_ORG -n used_bandwidth_egress_per_1h

influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f /docker-entrypoint-initdb.d/used_bandwidth_per_1m.flux
influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f /docker-entrypoint-initdb.d/used_bandwidth_per_5m.flux
influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f /docker-entrypoint-initdb.d/used_bandwidth_per_1h.flux

#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f /docker-entrypoint-initdb.d/used_bandwidth_ingress_per_svc_per_route_per_5m.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_ingress_per_svc_per_route_per_1h.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_ingress_per_svc_per_route_per_1d.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_ingress_per_svc_per_route_per_1M.flux

#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_egress_per_svc_per_route_per_5m.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_egress_per_svc_per_route_per_1h.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_egress_per_svc_per_route_per_1d.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_egress_per_svc_per_route_per_1M.flux

#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_ingress_per_svc_per_5m.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_ingress_per_svc_per_1h.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_ingress_per_svc_per_1d.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_ingress_per_svc_per_1M.flux

#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_egress_per_svc_per_5m.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_egress_per_svc_per_1h.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_egress_per_svc_per_1d.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_egress_per_svc_per_1M.flux

#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_ingress_per_5m.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_ingress_per_1h.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_ingress_per_1d.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_ingress_per_1M.flux

#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_egress_per_5m.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_egress_per_1h.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_egress_per_1d.flux
#influx task create --org $DOCKER_INFLUXDB_INIT_ORG -f used_bandwidth_egress_per_1M.flux

// Task Options
option task = {
  name: "Calculate ingress used bandwidth per service/route per 5 minute interval.",
  every: 5m,
}

// Aggregate ingress
from(bucket: "kong_prometheus_metrics_normalized_diffed")
  |> range(start: -task.every)
  |> filter(fn: (r) => r.type == "ingress")
  |> aggregateWindow(fn: sum, every: 1m)
  |> to(bucket: "used_bandwidth_ingress_per_svc_per_route_per_5m")

from(bucket: "kong_prometheus_metrics_normalized_diffed")
  |> range(start: -task.every)
  |> filter(fn: (r) => r.type == "ingress")
  |> group(columns: ["type", "service"])
  |> aggregateWindow(fn: sum, every: 1m)
  |> to(bucket: "used_bandwidth_ingress_per_svc_per_5m")

from(bucket: "kong_prometheus_metrics_normalized_diffed")
  |> range(start: -task.every)
  |> filter(fn: (r) => r.type == "ingress")
  |> group(columns: ["type"])
  |> aggregateWindow(fn: sum, every: 1m)
  |> to(bucket: "used_bandwidth_ingress_per_5m")

// Aggregate egress
from(bucket: "kong_prometheus_metrics_normalized_diffed")
  |> range(start: -task.every)
  |> filter(fn: (r) => r.type == "egress")
  |> aggregateWindow(fn: sum, every: 1m)
  |> to(bucket: "used_bandwidth_egress_per_svc_per_route_per_5m")

from(bucket: "kong_prometheus_metrics_normalized_diffed")
  |> range(start: -task.every)
  |> filter(fn: (r) => r.type == "egress")
  |> group(columns: ["type", "service"])
  |> aggregateWindow(fn: sum, every: 1m)
  |> to(bucket: "used_bandwidth_egress_per_svc_per_5m")

from(bucket: "kong_prometheus_metrics_normalized_diffed")
  |> range(start: -task.every)
  |> filter(fn: (r) => r.type == "egress")
  |> group(columns: ["type"])
  |> aggregateWindow(fn: sum, every: 1m)
  |> to(bucket: "used_bandwidth_egress_per_5m")

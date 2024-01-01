// Task Options
option task = {
  name: "Calculate ingress used bandwidth per service/route per 1 minute interval.",
  every: 1m,
}

// Aggregate ingress
from(bucket: "kong_prometheus_metrics_normalized_diffed")
  |> range(start: -task.every)
  |> filter(fn: (r) => r.type == "ingress")
  |> aggregateWindow(fn: sum, every: 10s)
  |> to(bucket: "used_bandwidth_ingress_per_svc_per_route_per_1m")

from(bucket: "kong_prometheus_metrics_normalized_diffed")
  |> range(start: -task.every)
  |> filter(fn: (r) => r.type == "ingress")
  |> group(columns: ["type", "service"])
  |> aggregateWindow(fn: sum, every: 10s)
  |> to(bucket: "used_bandwidth_ingress_per_svc_per_1m")

from(bucket: "kong_prometheus_metrics_normalized_diffed")
  |> range(start: -task.every)
  |> filter(fn: (r) => r.type == "ingress")
  |> group(columns: ["type"])
  |> aggregateWindow(fn: sum, every: 10s)
  |> to(bucket: "used_bandwidth_ingress_per_1m")

// Aggregate egress
from(bucket: "kong_prometheus_metrics_normalized_diffed")
  |> range(start: -task.every)
  |> filter(fn: (r) => r.type == "egress")
  |> aggregateWindow(fn: sum, every: 10s)
  |> to(bucket: "used_bandwidth_egress_per_svc_per_route_per_1m")

from(bucket: "kong_prometheus_metrics_normalized_diffed")
  |> range(start: -task.every)
  |> filter(fn: (r) => r.type == "egress")
  |> group(columns: ["type", "service"])
  |> aggregateWindow(fn: sum, every: 10s)
  |> to(bucket: "used_bandwidth_egress_per_svc_per_1m")

from(bucket: "kong_prometheus_metrics_normalized_diffed")
  |> range(start: -task.every)
  |> filter(fn: (r) => r.type == "egress")
  |> group(columns: ["type"])
  |> aggregateWindow(fn: sum, every: 10s)
  |> to(bucket: "used_bandwidth_egress_per_1m")

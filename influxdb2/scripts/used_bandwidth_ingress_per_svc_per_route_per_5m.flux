// Task Options
option task = {
  name: "Calculate ingress used bandwidth per service/route per 5 minute interval.",
  cron: "*/5 * * * *",
}

// Defines a data source
data_ingress = from(bucket: "kong_prometheus_metrics_normalized_diffed")
  |> range(start: -5m, stop: now())
  |> filter(fn: (r) => r.type == "ingress")

data_egress = from(bucket: "kong_prometheus_metrics_normalized_diffed")
  |> range(start: -5m, stop: now())
  |> filter(fn: (r) => r.type == "egress")

//Aggregate
data_ingress
  |> aggregateWindow(fn: sum, every: 5m)
  |> to(bucket: "used_bandwidth_ingress_per_svc_per_route_per_5m")

data_egress
  |> aggregateWindow(fn: sum, every: 5m)
  |> to(bucket: "used_bandwidth_egress_per_svc_per_route_per_5m")
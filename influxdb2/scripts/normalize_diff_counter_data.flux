option task = {
  name: "Normalize and diff Prometheus counter for kong_bandwidth",
  cron: "* * * * *",
}

from(bucket: "kong_prometheus_metrics")
  |> range(start: -1m, stop: now())
  |> group(columns: [])
  |> increase()
  |> difference()
  |> to(bucket: "kong_prometheus_metrics_normalized_diffed")
import "experimental/prometheus"

option task = {
  name: "Scrape Prometheus metrics",
  every: 5s
}

prometheus.scrape(url: "http://mock-kong-gateways:8001/metrics")
  |> filter(fn: (r) => r._measurement == "prometheus" and r._field == "kong_bandwidth")
  |> to(bucket: "kong_prometheus_metrics")
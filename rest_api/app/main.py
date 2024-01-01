import os
import re
import logging
from datetime import datetime
from typing import Optional, List, Union
from fastapi import FastAPI, Query, HTTPException
from pydantic import BaseModel
from prometheus_api_client import PrometheusConnect, MetricsList, Metric, MetricRangeDataFrame
from prometheus_api_client.utils import parse_datetime
from datetime import timedelta


logging.basicConfig(format='%(asctime)s %(levelname)s: %(message)s', level=logging.DEBUG)
logger = logging.getLogger(__name__)

for e in os.environ:
    if "INFLUX" in e:
        logger.info(f"{e}={os.environ.get(e)}")

app = FastAPI()

prom = PrometheusConnect(url=os.environ.get("PROMETHEUS_URL"), disable_ssl=True)


class BandwidthMetric(BaseModel):
    time: str
    type: str
    service: str
    route: str
    bandwidth_used: int

    @staticmethod
    def from_metric(metric: Metric):
        logger.debug(type(metric.metric_values))
        logger.debug(metric.metric_values.to_dict())
        return BandwidthMetric(
            time=metric.metric_values.to_dict()['ds'][0],
            type=metric.label_config['type'],
            service=metric.label_config['service'],
            route=metric.label_config['route'],
            bandwidth_used=metric.metric_values.to_dict()['y'][0]
        )


def get_bandwidth_used_from_prometheus(lookback_duration: str, flow_type: str, service: str, route: str) -> List[BandwidthMetric]:
    start_time = parse_datetime(lookback_duration)
    end_time = parse_datetime("now")
    chunk_size = timedelta(minutes=1)
    metric_data = prom.get_metric_range_data(
        f"kong_bandwidth{{service=\"{service}\", route=\"{route}\", type=\"{flow_type}\"}}",
        start_time=start_time,
        end_time=end_time,
        chunk_size=chunk_size
    )
    logger.debug(f"metric_data: {metric_data}")
    result = []
    if metric_data is not None and len(metric_data) > 0:
        metric_df = MetricRangeDataFrame(metric_data)
        for item in metric_df.itertuples(index=True):
            # logger.debug(type(item))
            # logger.debug(f"item: {item}")
            result.append(BandwidthMetric(
                time=item.Index,
                type=item.type,
                service=item.service,
                route=item.route,
                bandwidth_used=item.value
            ))

    logger.info(f"result: {result}")
    return result


@app.get('/metrics/bandwidth_used', response_model=List[BandwidthMetric])
def get_metrics(flow_type: str = Query(None, alias="type", regex="^(egress|ingress)$"),
                lookback_duration: str = Query(None, regex="^[0-9]+m$"),
                service: Optional[str] = Query(None, regex="^(bin-service|bun-service|ban-service)$"),
                route: Optional[str] = Query(None, regex="^(bin-route|bun-route|ban-route)$")) -> Union[List[BandwidthMetric], HTTPException]:
    try:
        result = get_bandwidth_used_from_prometheus(lookback_duration, flow_type, service, route)
        return result
    except Exception as ex:
        logger.error(ex)
        return HTTPException(status_code=500, detail=ex)

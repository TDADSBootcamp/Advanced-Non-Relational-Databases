#!/bin/bash

set -euo pipefail

# get the directory the script is in
BASEDIR=$(dirname "$0")

ES_TAG=$(cat ${BASEDIR}/es_version.txt)

echo "Running Kibana"

docker run \
  -p 5601:5601 \
  --net elasticsearch \
  -e ELASTICSEARCH_HOSTS=http://search-server:9200 \
  docker.elastic.co/kibana/kibana:${ES_TAG}

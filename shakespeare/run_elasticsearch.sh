#!/bin/bash

set -euo pipefail

# get the directory the script is in
BASEDIR=$(dirname "$0")

ES_TAG=$(cat ${BASEDIR}/es_version.txt)

echo "Creating Elasticsearch network"

docker network create elasticsearch || true

echo "Running Elasticsearch"

docker run \
  --rm \
  -p 9200:9200 \
  -p 9300:9300 \
  --name search-server \
  --net elasticsearch \
  -e "discovery.type=single-node" \
  docker.elastic.co/elasticsearch/elasticsearch:${ES_TAG}

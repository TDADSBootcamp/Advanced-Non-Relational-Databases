#!/bin/bash

set -euo pipefail

BASEDIR=$(dirname "$0")
DATASET_PATH=${BASEDIR}/uncommitted/shakespeare.json

echo "Creating index"

curl -XPUT http://localhost:9200/shakespeare || true

echo ""
echo "Setting up field mappings"

curl -XPUT \
  -H "Content-Type:application/json" \
  --data-binary "@${BASEDIR}/mapping.json" \
  http://localhost:9200/shakespeare/_mapping

echo ""
echo "Importing dataset"

curl -XPOST \
  -H "Content-Type:application/json" \
  --data-binary "@${BASEDIR}/uncommitted/shakespeare.json" \
  http://localhost:9200/shakespeare/_bulk?pretty > ${BASEDIR}/uncommitted/index.log


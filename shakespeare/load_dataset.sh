#!/bin/bash

set -euo pipefail

BASEDIR=$(dirname "$0")
DATASET_PATH=${BASEDIR}/uncommitted/shakespeare.json

echo "Creating index"

wget -O - \
  --method PUT \
  http://localhost:9200/shakespeare || true


echo "Setting up field mappings"

wget -O - \
  --method PUT \
  --body-file ${BASEDIR}/mapping.json \
  --header "Content-Type:application/json" \
  http://localhost:9200/shakespeare/_mapping

echo "Importing dataset"

wget -O - \
  --method POST \
  --body-file ${BASEDIR}/uncommitted/shakespeare.json \
  --header "Content-Type: application/x-ndjson" \
  localhost:9200/shakespeare/_bulk?pretty


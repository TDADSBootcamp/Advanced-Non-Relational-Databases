#!/bin/bash

set -eu

echo "Importing dataset"

neo4j-admin import \
  --database=neo4j \
  --nodes=/import/nodes.csv \
  --relationships=/import/relationships.csv

echo "Importing dataset done"
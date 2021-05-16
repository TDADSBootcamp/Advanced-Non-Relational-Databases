#!/bin/bash

BASEDIR=$(dirname "$0")

python3 ${BASEDIR}/people_to_neo.py < ${BASEDIR}/../people.csv \
  --nodes ${BASEDIR}/import/nodes.csv \
  --relationships ${BASEDIR}/import/relationships.csv

docker run \
  --env NEO4J_AUTH=none \
  --env EXTENSION_SCRIPT=/import/load_people.sh \
  --user $(id -u):$(id -g) \
  --volume $(readlink -f ${BASEDIR})/import:/import:ro \
  --volume :/data \
  -p 7474:7474 \
  -p 7687:7687 \
  neo4j:4.2
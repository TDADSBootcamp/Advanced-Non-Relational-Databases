#!/bin/bash

set -euo pipefail

DATASET_URL="https://download.elastic.co/demos/kibana/gettingstarted/shakespeare_6.0.json"

# get the directory the script is in
BASEDIR=$(dirname "$0")

UNCOMMITTED=${BASEDIR}/uncommitted
mkdir -p ${UNCOMMITTED}

DATASET_PATH=${UNCOMMITTED}/shakespeare.json

# download the dataset
wget ${DATASET_URL} -O ${DATASET_PATH}


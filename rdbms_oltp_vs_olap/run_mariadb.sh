#!/bin/bash

set -euo pipefail

BASEDIR=$(dirname "$0")
ABS_BASEDIR=$(readlink -f ${BASEDIR})

USERNAME=student
PASSWORD=letmein

CONTAINER_ID=$(docker run -d --rm -p3306:3306 -v ${ABS_BASEDIR}/..:/work -e ANALYTICS_ONLY=1 mariadb/columnstore)
echo "Kill this container with 'docker kill ${CONTAINER_ID}'"
sleep 10

docker exec ${CONTAINER_ID} mariadb -e "GRANT ALL PRIVILEGES ON *.* TO '${USERNAME}'@'%' IDENTIFIED BY '${PASSWORD}';"
#!/bin/bash

set -euo pipefail

BASEDIR=$(dirname "$0")
ABS_BASEDIR=$(readlink -f ${BASEDIR})

USERNAME=student
PASSWORD=letmein

CONTAINER_ID=$(docker run -d --rm -p3306:3306 -v ${ABS_BASEDIR}/..:/work mariadb/columnstore)
echo "Kill this container with 'docker kill ${CONTAINER_ID}'"

while : ; do
  echo "Waiting for server..."
  sleep 5
  echo "Trying to grant privileges..."
  docker exec ${CONTAINER_ID} mariadb -e "GRANT ALL PRIVILEGES ON *.* TO '${USERNAME}'@'%' IDENTIFIED BY '${PASSWORD}';"
  [[ "$?" -eq 1 ]] || break
done

echo "Enter a shell in the container: 'docker exec -it ${CONTAINER_ID} bash'"
echo "Kill this container: 'docker kill ${CONTAINER_ID}'"
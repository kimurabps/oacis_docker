#!/bin/bash

. ./test/base.sh

function db_dump_restore() {
  docker run --name ${OACIS_CONTAINER_NAME} -p ${PORT}:3000 -d ${OACIS_IMAGE}
  sleep 20
  datetime=`date +%Y%m%d-%H%M`
  docker exec -it ${OACIS_CONTAINER_NAME} bash -c "cd /home/oacis/oacis/public/Result_development; if [ ! -d db ]; then mkdir db; fi; cd db; mongodump --db oacis_development; mv dump dump-$datetime; chown -R oacis:oacis /home/oacis/oacis/public/Result_development/db"
  docker cp ${OACIS_CONTAINER_NAME}:/home/oacis/oacis/public/Result_development .
  test -d Result_development/db
}

db_dump_restore
rc=$?

rm -rf Result_development

exit $rc


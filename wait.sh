#!/bin/bash
timeout "${TIMEOUT:-10s}" \
    /bin/bash -c "until mysql -h'${MYSQL_HOST}' -P'${MYSQL_PORT}' -u'${MYSQL_USER}' -p'${MYSQL_PASS}' -e 'SELECT 1;'; do sleep 1; done" 2> /dev/null > /dev/null \
    && exit 0 || echo "Authentication to database on host ${MYSQL_HOST} failed." && exit 1


#!/bin/bash
[ -z "${MYSQL_HOST_FILE}" ] || { MYSQL_HOST=$(head -1 "${MYSQL_HOST_FILE}"); }
[ -z "${MYSQL_HOST}" ] && { echo "=> MYSQL_HOST cannot be empty" && exit 1; }
[ -z "${MYSQL_USER_FILE}" ] || { MYSQL_USER=$(head -1 "${MYSQL_USER_FILE}"); }
[ -z "${MYSQL_USER}" ] && { echo "=> MYSQL_USER cannot be empty" && exit 1; }
[ -z "${MYSQL_PASS_FILE}" ] || { MYSQL_PASS=$(head -1 "${MYSQL_PASS_FILE}"); }
[ -z "${MYSQL_PASS:=$MYSQL_PASSWORD}" ] && { echo "=> MYSQL_PASS cannot be empty" && exit 1; }

timeout "${TIMEOUT:-10s}" \
    /bin/bash -c "until mysql -h'${MYSQL_HOST}' -P'${MYSQL_PORT}' -u'${MYSQL_USER}' -p'${MYSQL_PASS}' -e 'SELECT 1;'; do sleep 1; done" 2> /dev/null > /dev/null \
    && exit 0 || echo "Authentication to database on host ${MYSQL_HOST} failed." && exit 1


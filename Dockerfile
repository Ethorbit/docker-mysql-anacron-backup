FROM alpine:3.19.1
LABEL maintainer "Ethorbit" 

ARG UID=1000
ARG GID=1000
ARG UNAME="mysql-backup"
ARG GNAME="mysql-backup"

#CRON_TIME="0 3 * * sun" \
ENV ANACRON_DAYS="7" \
    ANACRON_DELAY_MINUTES="1" \
    MYSQL_HOST="mysql" \
    MYSQL_PORT="3306" \
    TIMEOUT="10s" \
    MYSQLDUMP_OPTS="--quick"

WORKDIR "/home/${UNAME}"

RUN apk add --update \
        cronie \
        tzdata \
        bash \
        mysql-client \
        gzip \
        openssl \
        mariadb-connector-c && \
    addgroup -g "${GID}" "${GNAME}" && \
    adduser -D -G "${GNAME}" -u "${UID}" "${UNAME}" && \
    mkdir .anacron && \
    mkdir .anacron/etc && \
    mkdir .anacron/spool && \
    chown "${UNAME}":"${GNAME}" -R .anacron/ && \
    chmod 770 -R .anacron/ && \
    rm -rf /var/cache/apk/*

COPY [ "run.sh", "backup.sh", "restore.sh", "/delete.sh", "/" ]
RUN mkdir /backup && \
    chmod 777 /backup && \
    chmod 755 /run.sh /backup.sh /restore.sh /delete.sh && \
    touch /mysql_backup.log && \
    chmod 666 /mysql_backup.log

VOLUME [ "/backup", "/home/${UNAME}/.anacron/spool" ]

USER "${UNAME}"

CMD [ "/run.sh" ]
#CMD dockerize -wait tcp://${MYSQL_HOST}:${MYSQL_PORT} -timeout ${TIMEOUT} /run.sh

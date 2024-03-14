#!/bin/bash
printf "${ANACRON_DAYS}\t${ANACRON_DELAY_MINUTES}\tbackup\t/bin/bash /backup.sh\n" > "${HOME}/.anacron/etc/anacrontab"
cat "${HOME}/.anacron/etc/anacrontab"

while :; do
    anacron -d -s -t "${HOME}/.anacron/etc/anacrontab" -S "${HOME}/.anacron/spool"
    sleep 1h
done

sleep 5

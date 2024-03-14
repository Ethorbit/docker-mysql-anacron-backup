#!/bin/bash
readonly anacrontab="${HOME}/.anacron/etc/anacrontab"
readonly anacronspool="${HOME}/.anacron/spool"

# Create / update the anacrontab
printf "${ANACRON_DAYS}\t${ANACRON_DELAY_MINUTES}\tbackup\t/bin/bash /backup.sh\n" > "${anacrontab}"
cat "${anacrontab}"

# Run anacron every now and then to check if it's time to run a backup yet.
while :; do
    /wait.sh || break
    anacron -d -s -t "${anacrontab}" -S "${anacronspool}" || break
    sleep ${ANACRON_CHECK_DELAY:-60m}
done

# This shouldn't happen..
sleep 5 && exit 1

#!/bin/bash
version=$(git rev-parse --short HEAD)
docker build -t ethorbit/mysql-cron-backup:latest .
docker tag ethorbit/mysql-cron-backup:latest ethorbit/mysql-cron-backup:$version

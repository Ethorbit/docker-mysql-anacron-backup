#!/bin/bash
version=$(git rev-parse --short HEAD)
docker push ethorbit/mysql-cron-backup:latest;
docker push ethorbit/mysql-cron-backup:$version; 

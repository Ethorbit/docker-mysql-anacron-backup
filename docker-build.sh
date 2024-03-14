#!/bin/bash
version=$(git rev-parse --short HEAD)
docker build -t ethorbit/mysql-anacron-backup:latest .
docker tag ethorbit/mysql-anacron-backup:latest ethorbit/mysql-anacron-backup:$version

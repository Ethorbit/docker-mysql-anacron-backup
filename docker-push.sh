#!/bin/bash
version=$(git rev-parse --short HEAD)
docker push ethorbit/mysql-anacron-backup:latest;
docker push ethorbit/mysql-anacron-backup:$version;

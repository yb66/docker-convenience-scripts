#!/bin/bash

docker rmi $(docker images --format "table {{.Tag}}\t{{.ID}}" | grep "^<none>" | awk "{print $2}")

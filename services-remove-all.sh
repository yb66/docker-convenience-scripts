#!/bin/bash

docker service rm $(docker service ls --format {{.ID}})

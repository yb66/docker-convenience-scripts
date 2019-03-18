#!/bin/bash
#First check if the user provided all needed arguments
if [ "$1" = "" ]
then
        echo "Please provide a source volume name"
        echo "Usage: docker_export_volume {source volume} {export file name}."
        exit
fi

if [ "$2" = "" ]
then
        echo "Please provide a destination file name"
        echo "Usage: docker_export_volume {source volume} {export file name}."
        exit
fi


#Check if the source volume name does exist
docker volume inspect $1 > /dev/null 2>&1
if [ "$?" != "0" ]
then
        echo "The source volume \"$1\" does not exist"
        exit
fi

echo "Copying data from source volume \"$1\" to destination file \"$2\" in the current folder..."

CURRENT_FOLDER=`pwd`;

docker run --rm \
  --mount source="$1",target=/usr/data,type=volume \
  --mount source=$CURRENT_FOLDER,target=/usr/backup,type=bind \
  debian:jessie tar -czvf /usr/backup/"${@:2}" -C /usr/data/ .

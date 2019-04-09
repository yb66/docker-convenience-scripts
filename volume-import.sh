#!/bin/bash
#First check if the user provided all needed arguments
if [ "$1" = "" ]
then
  echo "Please provide a source file name."
  echo "Usage: docker_import_volume {source file} {target volume name}."
  exit
fi

# Work out the source file
DIR=$(dirname "$1")
FILE=$(basename "$1")
if [ "$DIR" = "." ]
then
  WORK_FOLDER=`pwd`;
else
  WORK_FOLDER=$DIR;
fi

if [ "$2" = "" ]
then
  echo "Please provide a target volume name, if not exist the volume will be created."
  echo "Usage: docker_import_volume {source file} {target volume name}."
  exit
fi


#Check if the source volume name does exist
docker volume inspect $2 > /dev/null 2>&1
if [ "$?" != "0" ]
then
  echo "The target volume \"$2\" does not exist, creating it."
  docker volume create --name $2
fi

echo "Copying data from source file [$FILE] in the [$WORK_FOLDER] to target volume [$2]..."

docker run --rm \
  --mount source="$2",target=/usr/data,type=volume \
  --mount source=$WORK_FOLDER,target=/usr/backup,type=bind \
  debian:jessie tar -xf /usr/backup/"$FILE" -C /usr/data/

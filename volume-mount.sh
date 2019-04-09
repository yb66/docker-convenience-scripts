#!/bin/bash

if [ "$1" = "" ]
then
  echo "Please provide a source volume name"
  exit
fi

if [ "$2" = "" ] 
then
  echo "Please provide a destination path name"
  exit
fi

docker run -v $1:$2 -it --rm alpine /bin/ash
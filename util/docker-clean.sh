#!/bin/sh

# Will leave base ubuntu -- but get rid of the rest
CONTID=`docker ps -a|tail -n +2| grep -vy ubuntu| awk '{print $1}'`
IMGID=`docker ps -a|tail -n +2| grep -vy ubuntu| awk '{print $2}'`

for cid in $CONTID
do
  echo "Removing container $cid"
  docker rm $cid
done
for iid in $CONTID
do
  echo "Removing image $iid"
  docker rmi $cid
done

docker ps -a

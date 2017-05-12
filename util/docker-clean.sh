#!/bin/sh

# Will leave base ubuntu -- but get rid of the rest
CONTID=`docker ps -a|tail -n +2| grep -vy ubuntu|grep -v mariadb| awk '{print $1}'`
#IMGID=`docker ps -a|tail -n +2| grep -vy ubuntu|grep -v mariadb| awk '{print $2}'`
IMGID=`docker images|tail -n +2| grep -vy ubuntu|grep -v mariadb| awk '{print $3}'`

for cid in $CONTID
do
  echo "Removing container $cid"
  docker rm $cid
done
for iid in $IMGID
do
  echo "Removing image $iid"
  docker rmi $iid
done

docker ps -a
docker images

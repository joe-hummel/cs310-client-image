#!/bin/bash
#
# BASH script to build docker image:
#
read -r image < ./docker/_image-name.txt
#
# remove previous image:
#
if docker manifest inspect "$image" > /dev/null 2>&1; then
  docker rmi "$image"
fi
#
# cleanup "dangling" images that aren't really needed, to 
# help conserve disk space:
#
docker image prune -f
#
# build new image:
#
docker build -t "$image" ./docker
#
# done!
#
echo ""
echo "If build was successful, run using './docker/run'"
echo "The prompt should change, and you will be"
echo "working inside a Linux-based environment."
echo "When you are ready to exit and return to your"
echo "local environment, type 'exit'"
echo "" 

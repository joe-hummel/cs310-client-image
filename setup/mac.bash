#!/bin/bash
#
# BASH script to setup for Mac usage:
#
echo "starting setup"
#
# make all the scripts executable:
#
chmod 755 ./docker/*.bash
#
# make sure all the files are in Linux format:
#
sed -i '' 's/\r$//' ./.bashrc
sed -i '' 's/\r$//' ./docker/build.bash
sed -i '' 's/\r$//' ./docker/run.bash
sed -i '' 's/\r$//' ./docker/_image-name.txt
sed -i '' 's/\r$//' ./docker/Dockerfile
#
# setup to run scripts without .bash extension:
#
if [[ -e ./docker/build ]]; then
  rm -f ./docker/build
fi
if [[ -e ./docker/run ]]; then
  rm -f ./docker/run
fi
#
cp ./docker/build.bash ./docker/build
cp ./docker/run.bash ./docker/run
#
echo "done"
echo "to build docker container: ./docker/build"
echo "to run docker container: ./docker/run"
echo "to exit docker container: exit"
echo "have fun!"

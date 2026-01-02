#!/bin/bash
#
# BASH script to run docker image in a docker container:
#
read -r image < ./docker/_image-name.txt
#
# Some notes:
#  -it  => iteractive
#  -u   => run as this user 
#  -w   => home dir
#  -v   => map current dir (.) TO home dir
#  --rm => remove container when done
#
docker run -it -u user -w /home/user -v .:/home/user --network="host" --ipc="host" --name "$image" --rm "$image" bash

#!/bin/bash
set -e
set -x 

docker container run \
    --detach \
    --privileged \
    --rm \
    --name adass \
    -p 9999:8888 \
    ryantanaka/adass21-montage

 docker exec -it -u scitech adass /bin/bash

 docker kill adass


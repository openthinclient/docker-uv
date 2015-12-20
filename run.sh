#!/bin/bash

install() {
    docker run -it \
        --name otc \
        --net host \
        --env="DISPLAY" \
        --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
        otc-univention \
        sh /tmp/data/postinstall.sh
## Useful if name is not static ##
#    export containerId='docker ps -l -q'
}

start_otc() {
    docker start otc
    docker exec otc /opt/openthinclient/bin/start.sh restart
}

stop_otc() {
    docker exec otc /opt/openthinclient/bin/start.sh stop
    sleep 2
    docker stop otc
}

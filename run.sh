#!/bin/bash

key="$1"

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

key="$1"

case $key in
    -h|--help)
        echo -e "synopsis: install | start | stop"
        shift
    ;;
    -i|--install)
        install
        shift
    ;;
    --start)
         start_otc 
         shift
     ;;
     --stop)
         stop_otc
         shift
     ;;
     *)
        echo "parameter not known. -h | --help for manual"
    ;;
esac
shift


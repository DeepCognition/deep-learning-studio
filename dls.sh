#!/bin/bash

DATA_DIR=`pwd`/../data
PORT_NUM=80
DOCKER_CMD=/usr/bin/nvidia-docker
RED='\033[1;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'

if [ ! -f "$DOCKER_CMD" ]; then
    echo
    echo -e "${RED}nvidia-docker is not installed. Deep learning studio will run in ${GREEN}CPU mode.${NC}"
    echo
    echo "If your system contains nvidia GPU, you can install nvidia-docker from https://github.com/NVIDIA/nvidia-docker/wiki/Installation "
    echo
    DOCKER_CMD=docker
fi
usage() { 
    echo "Usage: $0 [option...] {update|run|stop}"
    echo 
    echo "  run options:"
    echo "       -d, --data  specify the data directory (absolute path)"
    echo "       -p, --port  specify the deep learning studio port number"
    exit 1;
}
update() {
    echo "Updating..."
    docker pull deepcognition/deep-learning-studio:latest
}

stop () {
    docker stop deep-learning-studio
}

run() {
    update
    if [ ! -d "$DATA_DIR/database" ]; then
        mkdir -p $DATA_DIR/database
        mkdir $DATA_DIR/keras
    fi
    COMPUTE_PORT=`expr $PORT_NUM + 1`
    options=" -p $PORT_NUM:80 -p $COMPUTE_PORT:80 -p 8888:8888"
    options+=" -v $DATA_DIR:/data"
    options+=" -v $DATA_DIR/database:/home/app/database"
    options+=" -v ${DATA_DIR}/keras:/root/.keras"
    docker rm deep-learning-studio 2>/dev/null
    echo "Starting..."
    $DOCKER_CMD run -d $options --name deep-learning-studio deepcognition/deep-learning-studio
    echo Done
    echo
    echo -e "Go to ${GREEN}http://127.0.0.1:"$PORT_NUM"/app/${NC} to start using Deep Learning Studio"
}

while getopts :d:p: option
do
    case "${option}" in
            d) DATA_DIR=${OPTARG};;
            p) PORT_NUM=${OPTARG};;
            *) usage
    esac
done

shift $((OPTIND-1))

case $1 in
    update) update;;
    run) run;;
    stop) stop;;
    *) usage
esac


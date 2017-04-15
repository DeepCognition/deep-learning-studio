#!/bin/bash -e

DATA_DIR=$HOME/.deepcognition/dls/data
PORT_NUM=80
DOCKER_CMD=/usr/bin/nvidia-docker
RED='\033[1;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'
IMAGE='deepcognition/deep-learning-studio:latest'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -f $SCRIPT_DIR/EULA.md ]; then
    echo License file is missing. Please download the whole package from https://github.com/DeepCognition/deep-learning-studio and try again.
    exit 1
fi

if [ ! -f $SCRIPT_DIR/.accepted ]; then
    more $SCRIPT_DIR/EULA.md
    echo 
    echo -e -n "Accept this agreement (${GREEN}y${NC}/${RED}n${NC}):"
    read response

    if [ ! "$response" == "y" ]; then
        exit 1
    fi

    touch  $SCRIPT_DIR/.accepted
    echo Downloading....
    docker pull $IMAGE
fi

usage() { 
    echo "Usage: $0 [option...] {uninstall|update|start|stop}"
    echo 
    echo "  run options:"
    echo "       -d, --data  specify the data directory (absolute path)"
    echo "       -p, --port  specify the deep learning studio port number"
    exit 1;
}

uninstall() {

    echo -e -n "Do you want to delete the data folder ($DATA_DIR) (${GREEN}y${NC}/${RED}n${NC}):"
    read response

    if [ ! "$response" == "y" ]; then
        rm -rf $DATA_DIR
    fi
    docker stop deep-learning-studio
    docker rm deep-learning-studio
    docker rmi $IMAGE

    echo Done
}
update() {
    echo "Updating..."
    docker pull $IMAGE
}

stop () {
    docker stop deep-learning-studio
}

run() {
    update
    if [ ! -f "$DOCKER_CMD" ]; then
        echo
        echo -e "${RED}nvidia-docker is not installed. Deep learning studio will run in ${GREEN}CPU mode.${NC}"
        echo
        echo "If your system contains nvidia GPU, you can install nvidia-docker from https://github.com/NVIDIA/nvidia-docker/wiki/Installation "
        echo
        DOCKER_CMD=docker
    fi
    if [ ! -d "$DATA_DIR/database" ]; then
        mkdir -p $DATA_DIR/database
        mkdir $DATA_DIR/keras
    fi
    COMPUTE_PORT=`expr $PORT_NUM + 1`
    options=" -p $PORT_NUM:80 -p $COMPUTE_PORT:80 -p 8888:8888 -p 8880:8880"
    options+=" -v $DATA_DIR:/data"
    options+=" -v $DATA_DIR/database:/home/app/database"
    options+=" -v ${DATA_DIR}/keras:/root/.keras"
    docker rm deep-learning-studio 2>/dev/null || true
    echo "Starting..."
    $DOCKER_CMD run -d $options --name deep-learning-studio $IMAGE
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
    start) run;;
    stop) stop;;
    *) usage
esac


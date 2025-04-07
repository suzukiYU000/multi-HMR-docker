#!/bin/bash

cd `dirname $0`

xhost +local:user
nvidia-docker &> /dev/null
if [ $? -ne 0 ]; then
    echo "=============================" 
    echo "=nvidia docker not installed="
    echo "============================="
    docker_installed=0
    nvidia-container-toolkit -version &> /dev/null
    if [ $? -ne 0 ]; then
        echo "========================================" 
        echo "=nvidia-container-toolkit not installed="
        echo "========================================"
        docker_installed=0
    else
        echo "=====================================" 
        echo "=nvidia-container-toolkit installed="
        echo "===================================="
        docker_installed=1
    fi
else
    docker_installed=1
fi
if [ $docker_installed != 1 ]; then
    echo $TAG
    echo "=============================" 
    echo "=nvidia docker not installed="
    echo "============================="
    docker run -it \
    --privileged \
    --env=DISPLAY=$DISPLAY \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="QT_X11_NO_MITSHM=1" \
    --rm \
    -v "/$(pwd)/global_ros_setting.sh:/ros_setting.sh" \
    -v "/$(pwd)/ros_workspace:/catkin_ws/" \
    -v "/$(pwd)/../multi-hmr_modules:/catkin_ws/src/multi-hmr_modules" \
    -v "/$(pwd)/../third_party:/catkin_ws/src/third_party" \
    -v "${PWD}/config/terminator_config:/home/${USER}/.config/terminator/config" \
    -v /etc/group:/etc/group:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v /media:/media \
    -v /dev:/dev \
    --net host \
    ${USER}/vibe
else
    echo "=========================" 
    echo "=nvidia docker installed="
    echo "========================="
    set -euxo pipefail
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    docker run --gpus all -e CUDA_VISIBLE_DEVICES=0 -it \
    --env=DISPLAY=$DISPLAY \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="QT_X11_NO_MITSHM=1" \
    --rm \
    -v "${SCRIPT_DIR}/../multi-hmr_modules:/catkin_ws/src/multi-hmr_modules"\
    -v "${SCRIPT_DIR}/config/terminator_config:/home/${USER}/.config/terminator/config" \
    -v /etc/group:/etc/group:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v /media:/media \
    --net host \
    ${USER}/multi-hmr
    echo "=========================" 
fi
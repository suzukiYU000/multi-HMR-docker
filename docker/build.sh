 #!/bin/bash -x

cd `dirname $0`

nvidia-docker &> /dev/null
if command -v nvidia-docker &> /dev/null; then
    echo "=========================" 
    echo "=nvidia docker installed="
    echo "========================="
    gpu_enabled=true
elif command -v nvidia-container-toolkit &> /dev/null; then
    echo "====================================" 
    echo "=nvidia container toolkit installed="
    echo "===================================="
    gpu_enabled=true
else
    echo "=========================================================" 
    echo "=nvidia docker or nvidia container toolkit not installed="
    echo "========================================================="
    gpu_enabled=false
fi
if ! $gpu_enabled; then
    echo "=============================" 
    echo "=nvidia docker not installed="
    echo "============================="
    docker build  --tag ${USER}/multi-hmr --build-arg USER=${USER} --build-arg USER_ID=`id -u` --build-arg workspace="/home/${USER}/catkin_ws/src/" -f Dockerfile.wogpu .
else
    echo "=========================" 
    echo "=nvidia docker installed="
    echo "========================="
    # if [[ $USER =~ .*js.* ]]; then
    # # jetson
    #     echo "=========================" 
    #     echo "=         jetson        ="
    #     echo "========================="
    #     docker build  --tag ${USER}/multi-hmr_modules --build-arg USER=${USER} --build-arg USER_ID=`id -u` --build-arg workspace="/home/${USER}/catkin_ws" -f Dockerfile.jetson .
    # else
    #     # other pc
    docker build  --tag ${USER}/multi-hmr --build-arg USER=${USER} --build-arg USER_ID=`id -u` --build-arg workspace="/home/${USER}/catkin_ws" .
    
fi

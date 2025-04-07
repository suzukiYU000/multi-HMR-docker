#!/bin/bash 

# nvidia-smi
# which python3
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PYTHONPATH=/usr/local/lib/python3.8/site-packages:$PYTHONPATH
/home/$(whoami)/.bashrc
source /ros_setting.sh
echo $PYTHONPATH
echo $LD_LIBRARY_PATH

roslaunch feeling visualize_feeling.launch

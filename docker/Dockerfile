# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
FROM nvidia/cuda:12.1.0-base-ubuntu20.04
ARG USER=initial
ARG GROUP=initial
ARG UID=1000
ARG GID=${UID}
ARG SHELL=/bin/bash
#FROM $base_image
RUN echo base image: ${base_image}

ENV CUDA_VISIBLE_DEVICES=0
#######################################################################
##                            Speeding up                            ##
#######################################################################
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

#######################################################################
##                      install common packages                      ##
#######################################################################
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
   pkg-config \
   apt-utils \
   wget \
   git \
   build-essential \ 
   net-tools \
   gedit \
   terminator \
   nautilus \
   apt-transport-https \
   libopencv-dev \
   ffmpeg \
   x264 \
   libx264-dev \
   zip \
   unzip \
   usbutils \
   sudo \
   python3-pip \
   libusb-1.0-0-dev \
   dbus-x11


#######################################################################
##                           install python                          ##
#######################################################################

# Install add-apt-repository support
RUN apt-get update && apt-get install -y software-properties-common

# Add deadsnakes PPA and install Python 3.9
RUN add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.9 python3.9-dev python3.9-distutils && \
    ln -s /usr/bin/python3.9 /usr/local/bin/python3.9

# Use the correct get-pip script for Python 3.9
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3.9 get-pip.py && \
    rm get-pip.py
# Install pip for Python 3.9
RUN python3.9 -m pip install --upgrade pip

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1


#######################################################################
##                           install font                            ##
#######################################################################
# RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections 
# RUN apt-get update && apt-get install -y ttf-mscorefonts-installer \
#     ttf-ubuntu-font-family \
#     msttcorefonts -qq \
#     libegl1-mesa \
#     libgl1-mesa-glx \
#     libgles2-mesa-dev
# RUN apt-get update && apt-get install -y libegl1-mesa libgl1-mesa-glx libgles2-mesa-dev

# RUN python3 -m pip install --upgrade pip
# RUN pip install --upgrade pip setuptools wheel
# RUN apt-get install  -y python3-ruamel.yaml

#######################################################################
##                       install nvidia docker                       ##
#######################################################################
RUN apt-get install -y --no-install-recommends \
    libxau-dev \
    libxdmcp-dev \
    libxcb1-dev \
    libxext-dev \
    libx11-dev \
    mesa-utils \
    x11-apps
RUN apt-get update && apt-get install -y --no-install-recommends \
    libegl1 \
    libegl-mesa0 \
    libglu-dev \
    libgles2-mesa-dev \
    mesa-utils \
    && rm -rf /var/lib/apt/lists/*

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

# Required for non-glvnd setups.
ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}:/usr/local/nvidia/lib:/usr/local/nvidia/lib64

#######################################################################
##                            install VIBE                           ##
#######################################################################
# Python環境設定
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1

# pipアップグレード
RUN python -m pip install --upgrade pip

# Python 環境設定：python3.9 をデフォルトに設定
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1

# pip のアップグレード
RUN python -m pip install --upgrade pip

# 必要な Python パッケージをインストール
RUN pip install \
    torch==2.0.1 \
    trimesh==3.22.3 \
    pyrender==0.1.45 \
    einops==0.6.1 \
    roma \
    pillow==10.0.1 \
    smplx \
    pyvista==0.42.3 \
    numpy==1.22.4 \
    pyglet==1.5.24 \
    tqdm==4.65.0 \
    xformers==0.0.20 \
    gradio==4.18.0 \
    spaces==0.19.4 \
    tensorboard==2.16.2 \
    plyfile==1.0.3 \
    chumpy==0.70
RUN pip install --upgrade pyvista


#######################################################################
##                            delete cash                            ##
#######################################################################
RUN rm -rf /var/lib/apt/lists/*

#######################################################################
##                         make sudoer user                          ##
#######################################################################

ARG USER
ARG USER_ID
RUN groupadd -g 1000 developer && \
    useradd  -g      developer -G sudo -m -u $USER_ID -s /bin/bash ${USER} && \
    echo "${USER}:${USER}" | chpasswd

RUN echo "Defaults visiblepw" >> /etc/sudoers
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#######################################################################
##                    make user accessible to usb                    ##
#######################################################################
RUN adduser ${USER} dialout


# USER root
RUN echo "export PS1='\[\e[1;31;40m\]HMR\[\e[0m\] \u:\w\$ '">> ~/.bashrc
# RUN echo "source /ros_setting.sh">> ~/.bashrc


WORKDIR /catkin_ws/src/multi-hmr_modules

CMD ["/bin/bash"]

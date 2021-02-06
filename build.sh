#!/bin/bash

set -x

architecture=$(dpkg --print-architecture)

if [ "$architecture" = "armhf" ]; then
  apt-get install -y --no-install-recommends \
                                  apt-transport-https \
                                  ca-certificates \
                                  gnupg \
                                  software-properties-common \
                                  wget
  wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
  apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main' && \
  apt-get update && apt-get install -y cmake
fi

source /opt/ros/noetic/setup.bash
mkdir -p /catkin_ws/src
cd /catkin_ws/src || exit
catkin_init_workspace
cd /catkin_ws || exit
catkin_make
source /catkin_ws/devel/setup.bash
chmod +x /ros_entrypoint.sh
apt autoclean -y
apt autoremove -y
rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
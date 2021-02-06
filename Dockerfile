FROM ros:noetic-ros-core-focal

LABEL maintainer="INTEC Inc<info-rdbox@intec.co.jp>"

ENV ROS_DISTRO=noetic

COPY ./ros_entrypoint.sh /ros_entrypoint.sh
COPY ./build.sh /build.sh

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                                    git \
                                    build-essential \
                                    iputils-ping \
                                    net-tools

RUN /build.sh

RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
                mkdir -p /catkin_ws/src && \
                cd /catkin_ws/src && \
                catkin_init_workspace && \
                cd /catkin_ws/ && \
                catkin_make && \
                source /catkin_ws/devel/setup.bash && \
                chmod +x /ros_entrypoint.sh && \
                apt autoclean -y && \
                apt autoremove -y && \
                rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*"

ENTRYPOINT ["/ros_entrypoint.sh"]
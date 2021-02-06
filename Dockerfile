FROM ros:noetic-ros-base-focal

LABEL maintainer="INTEC Inc<info-rdbox@intec.co.jp>"

ENV ROS_DISTRO=noetic

COPY ./ros_entrypoint.sh /ros_entrypoint.sh

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                                    git \
                                    build-essential \
                                    iputils-ping \
                                    net-tools

RUN /bin/bash -c ". /opt/ros/noetic/setup.bash && \
                mkdir -p /catkin_ws/src && \
                cd /catkin_ws/src && \
                catkin_init_workspace"

RUN /bin/bash -c ". /opt/ros/noetic/setup.bash && \
                cd /catkin_ws/ && \
                catkin_make && \
                . /catkin_ws/devel/setup.bash && \
                chmod +x /ros_entrypoint.sh && \
                apt autoclean -y && \
                apt autoremove -y && \
                rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*"

ENTRYPOINT ["/ros_entrypoint.sh"]
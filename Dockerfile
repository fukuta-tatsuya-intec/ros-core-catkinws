FROM ros:noetic-ros-core-focal

LABEL maintainer="INTEC Inc<info-rdbox@intec.co.jp>"

ENV ROS_DISTRO=noetic

COPY ./ros_entrypoint.sh /ros_entrypoint.sh

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                                    git \
                                    build-essential \
                                    iputils-ping \
                                    net-tools

RUN /bin/bash ./build.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
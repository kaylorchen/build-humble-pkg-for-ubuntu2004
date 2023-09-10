# Version 1.0
FROM ubuntu:20.04

# 维护者
LABEL maintainer="kaylor.chen@qq.com"

COPY 99user /etc/apt/apt.conf.d/
COPY ros-archive-keyring.gpg /usr/share/keyrings/
COPY rosdep-humble-backport.yaml /etc/ros/rosdep
COPY 30-rosdep-humble-backport.list /etc/ros/rosdep/sources.list.d
# 镜像操作命令
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://mirrors.cloud.tencent.com/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null && \
    sed -i "s/archive.ubuntu.com/mirrors.cloud.tencent.com/g" /etc/apt/sources.list && \
    sed -i "s/security.ubuntu.com/mirrors.cloud.tencent.com/g" /etc/apt/sources.list && \
    apt update && apt install -y \
    python3-flake8-docstrings \
    python3-pip \
    python3-pytest-cov \
    ros-dev-tools && \
    python3 -m pip install -U \
    flake8-blind-except \
    flake8-builtins \
    flake8-class-newline \
    flake8-comprehensions \
    flake8-deprecated \
    flake8-import-order \
    flake8-quotes \
    "pytest>=5.3" \
    pytest-repeat \
    pytest-rerunfailures && \
    rosdep init && rosdep update && \
    apt install -y dh-python debhelper git devsrcipt fakeroot python3-bloom


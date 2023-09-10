# Version 1.0
FROM kaylor/focal_humble_env:compile1.3

# 维护者
LABEL maintainer="kaylor.chen@qq.com"

# 镜像操作命令
RUN apt-get update && apt-get install -y ros-humble-control-msgs 

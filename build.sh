#!/bin/bash

MAIN_DIR=$(pwd)
ROS_DISTRO=humble
ARCH=amd64
DIST=$(lsb_release -c | awk '{print $2}')
echo "Arch is $ARCH and DIST is $DIST"
mkdir -p  $MAIN_DIR/deb
source /opt/ros/${ROS_DISTRO}_compile/setup.bash
printenv | grep ROS
# python3 get_package_path.py
cat packages-path.txt | while read i
do
  if [ -d "${i}" ]; then
    pushd $i
    echo "--------------------------------"
    if [ -f "COLCON_IGNORE" ]; then
      echo "${i}/COLCON_IGNORE exist"
    else
      PACKAGE_NAME=$(python3 ${MAIN_DIR}/get_package_name.py)
      rm debian -rf
      bloom-generate rosdebian --os-name ubuntu --ros-distro humble
      NOW=$(date "+%Y%m%d.%H%M%S") 
      sed -i "0,/focal/s//focal.${NOW}/" debian/changelog 
      DEB_PREFIX=$(grep ${NOW} debian/changelog | awk '{print $1}')
      # DEB=$(grep ${NOW} debian/changelog | awk '{print $1}')$(grep ${NOW} debian/changelog | awk '{print $2}')${ARCH}.deb
      # DEB=$(echo ${DEB} | sed -e 's/(/_/g' | sed -e 's/)/_/g')
      # echo DEB=${DEB}
      DEB_BUILD_OPTIONS='parallel=7' fakeroot debian/rules binary
      echo -e "\033[35m move ${DEB_PREFIX} package \033[0m"
      mv ../${DEB_PREFIX}*.deb ${MAIN_DIR}/deb
      mv ../${DEB_PREFIX}*.ddeb ${MAIN_DIR}/deb
      fakeroot debian/rules clean
      rm -rf debian
    fi
    echo "********************************"
    popd
  fi
done
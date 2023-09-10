#!/bin/bash

pkg_list=${1}
MAIN_DIR=$(pwd)
echo "MAIN_DIR is $MAIN_DIR"
ROS_DISTRO=humble
ARCH=amd64
DIST=$(lsb_release -c | awk '{print $2}')
echo "Arch is $ARCH and DIST is $DIST"
mkdir -p  $MAIN_DIR/deb
source /opt/ros/${ROS_DISTRO}/setup.bash
printenv | grep ROS
#python3 get_package_path.py
apt update
cat ${pkg_list}| while read i
do
  if [ -d "${i}" ]; then
    pushd $i
    echo "--------------------------------"
    if [ -f "COLCON_IGNORE" ]; then
      echo "${i}/COLCON_IGNORE exist"
    else
      sed -i 's/jammy/focal/g' debian/changelog 
      sed -i 's|dh_shlibdeps |dh_shlibdeps --dpkg-shlibdeps-params=--ignore-missing-info |' debian/rules
      cat debian/rules
      ls -al debian/rules
      chmod a+x debian/rules
      ls -al debian/rules
      DEB_BUILD_OPTIONS='parallel=16' fakeroot debian/rules binary
      echo -e "\033[35m move package \033[0m"
      mv ../*.deb ${MAIN_DIR}/deb
      mv ../*.ddeb ${MAIN_DIR}/deb
      apt install -y ${MAIN_DIR}/deb/*.deb
      rosdep install --from-paths $(pwd) --ignore-src -y
      fakeroot debian/rules clean
    fi
    echo "********************************"
    popd
  fi
done

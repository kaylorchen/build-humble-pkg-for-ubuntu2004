#!/bin/bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DE86F73ED9E67D5E
echo "deb http://42.194.233.81:60000/ros2/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/kaylor-ros2.list > /dev/null
sudo apt update
sudo apt install -y tree python3-vcstool python3-apt
./check_package.py --cfg user.repos
cat updates.repos
echo -e "\033[36m ********************* \033[0m"  
ls -al
cat repos${1}.repos
mkdir -pv src
mkdir -pv deb
vcs import src < repos${1}.repos
python3 get_package_path.py
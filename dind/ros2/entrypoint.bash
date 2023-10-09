#!/bin/bash

echo ''
echo '======== Loading the ROS 2 environment ========'
echo ''

CMD="source /opt/ros/humble/setup.sh"
echo "$CMD" && eval "$CMD" || exit $?

if [ ! -z "$APT_URL_PACKAGES" ]
then
  echo ''
  echo '======== Installing APT packages ========'
  echo ''

  mkdir /apt && cd /apt && \
  echo "$APT_URL_PACKAGES" && apt-get update && \
  wget $APT_URL_PACKAGES && \
  apt-get install -y /apt/*.deb || exit $?
fi

echo ''
echo '======== Building the workspace ========'
echo ''

cd /ws && colcon build \
  --event-handlers console_cohesion+ \
  --cmake-args || exit $?

source install/setup.bash || exit $?
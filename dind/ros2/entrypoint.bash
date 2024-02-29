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

if [ ! -z "$EXTERNAL_REPOS" ]
then
  echo ''
  echo '======== Cloning external repositories ========'
  echo ''

  cd /ws || exit $?

  for REPO in $EXTERNAL_REPOS
  do
    VALUES=(${REPO//#/ })

    URL="${VALUES[0]}"
    BRANCH="${VALUES[1]}"

    if [ -z "$BRANCH" ]
    then
      CMD="git clone $URL"
      if ! (echo "$CMD" && eval "$CMD")
      then
        CMD="git clone https://github.com/$URL.git"
        echo "$CMD" && eval "$CMD" || exit $?
      fi
    else
      CMD="git clone -b $BRANCH $URL"
      if ! (echo "$CMD" && eval "$CMD")
      then
        CMD="git clone -b $BRANCH https://github.com/$URL.git"
        echo "$CMD" && eval "$CMD" || exit $?
      fi
    fi
  done
fi


echo ''
echo '======== Listing packages in the workspace ========'
echo ''

cd /ws && colcon list --names

echo ''
echo '======== Building the workspace ========'
echo ''

cd /ws && colcon build \
  --event-handlers console_cohesion+ \
  --cmake-args || exit $?

source install/setup.bash || exit $?
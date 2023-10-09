#!/bin/sh

echo ''
echo '======== Running the Docker daemon ========'
echo ''

dockerd-entrypoint.sh &
sleep 10

mkdir "/ros2/ws" && cp -r "${GITHUB_WORKSPACE}" "/ros2/ws/repo" || exit $?

echo ''
echo '======== Building the ROS 2 image ========'
echo ''


docker build \
  -t ros2-ci:latest /ros2 || exit $?

echo ''
echo '======== Running the ROS 2 container ========'
echo ''

docker run \
  --rm ros2-ci:latest || exit $?
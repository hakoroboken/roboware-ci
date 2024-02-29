#!/bin/sh

APT_URL_PACKAGES="${1}"
EXTERNAL_REPOS="${2}"

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

docker run --env APT_URL_PACKAGES="${APT_URL_PACKAGES}" --env EXTERNAL_REPOS="${EXTERNAL_REPOS}" --rm ros2-ci:latest || exit $?
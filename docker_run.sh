#!/bin/bash
IMAGE_NAME="$1"
IMAGE_TAG="latest"
if [ -n "${2}" ]; then
	IMAGE_TAG="${2}"
fi
SCRIPT_PATH=$(readlink "$0")
HOST_VOLUME_PATH=$(dirname "${SCRIPT_PATH}")
docker run \
  --name "${IMAGE_NAME}" \
  -it \
  --rm \
  -v "${HOST_VOLUME_PATH}":/root/prj \
  -v /home/chris/.gitconfig:/root/.gitconfig \
  -v /home/chris/.ssh:/root/.ssh \
	"${IMAGE_NAME}":"${IMAGE_TAG}" \
  bash

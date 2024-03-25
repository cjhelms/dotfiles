#!/bin/bash
BASE_IMAGE="ubuntu"
BASE_TAG="latest"
if [ -n "${1}" ]; then
	BASE_IMAGE="${1}"
fi
if [ -n "${2}" ]; then
	BASE_TAG="${2}"
fi
docker build \
	--build-arg BASE_IMAGE="${BASE_IMAGE}" \
	--build-arg BASE_TAG="${BASE_TAG}" \
	-t "${BASE_IMAGE}:${BASE_TAG}-dev" \
	~/.dotfiles

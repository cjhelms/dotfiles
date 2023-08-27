#!/bin/bash
BASE_IMAGE="ubuntu"
BASE_TAG="latest"
DOTFILES_CHECKOUT="6da61b6facec86c4596b06668cff889b6dc613cb"
if [ -n "${1}" ]; then
	BASE_IMAGE="${1}"
fi
if [ -n "${2}" ]; then
	BASE_TAG="${2}"
fi
if [ -n "${3}" ]; then
	DOTFILES_CHECKOUT="${3}"
fi
echo ${DOTFILES_CHECKOUT}
docker build \
	--build-arg BASE_IMAGE="${BASE_IMAGE}" \
	--build-arg BASE_TAG="${BASE_TAG}" \
	--build-arg DOTFILES_CHECKOUT="${DOTFILES_CHECKOUT}" \
	-t "${BASE_IMAGE}:${BASE_TAG}-dev" \
	~/.dotfiles

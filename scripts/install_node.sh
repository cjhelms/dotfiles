#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib.sh"

NVM_VERSION="${NVM_VERSION:-0.40.4}"
NODE_VERSION="${NODE_VERSION:-25}"

apt_install curl

if [ ! -s "${HOME}/.nvm/nvm.sh" ]; then
  curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash
fi

\. "${HOME}/.nvm/nvm.sh"

nvm install "${NODE_VERSION}"
nvm use "${NODE_VERSION}"

node -v
npm -v

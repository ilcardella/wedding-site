#!/usr/bin/env bash

# Bash safety settings
set -eu -o pipefail

# For staging builds deploy in /tmp
if [[ $1 == "staging" ]]; then
    DEPLOY_DIRECTORY="/tmp/"
fi

DEPLOY_SSH_PATH="${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_DIRECTORY}"

# Deploy the content of the public folder
rsync -r --quiet --delete-after ${TRAVIS_BUILD_DIR}/public/* ${DEPLOY_SSH_PATH}/public/
# Deploy the docker-compose file
rsync --quiet ${TRAVIS_BUILD_DIR}/docker-compose.yml ${DEPLOY_SSH_PATH}
# Deploy the .env file created during the CI build
rsync --quiet ${TRAVIS_BUILD_DIR}/.env ${DEPLOY_SSH_PATH}

# Restart the nginx server only for production deployment
if [[ $1 == "production" ]]; then
ssh ${DEPLOY_USER}@${DEPLOY_HOST} /bin/bash <<EOF
cd ${DEPLOY_DIRECTORY}
docker-compose down
EOF

ssh ${DEPLOY_USER}@${DEPLOY_HOST} /bin/bash <<EOF
cd ${DEPLOY_DIRECTORY}
docker-compose up -d nginx-server
EOF
fi

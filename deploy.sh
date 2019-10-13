#!/usr/bin/env bash

# Bash safety settings
set -eu -o pipefail

DEPLOY_SSH_PATH=${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_DIRECTORY}

# Deploy the content of the public folder
rsync -r --quiet --delete-after ${TRAVIS_BUILD_DIR}/public/* ${DEPLOY_SSH_PATH}/public/
# Deploy the docker-compose file
rsync --quite --delete-after ${TRAVIS_BUILD_DIR}/docker-compose.yml ${DEPLOY_SSH_PATH}
# Deploy the .env file created during the CI build
rsync --quite --delete-after ${TRAVIS_BUILD_DIR}/.env ${DEPLOY_SSH_PATH}

# Restart the server container
ssh ${DEPLOY_USER}@${DEPLOY_HOST} <<EOF
cd ${DEPLOY_DIRECTORY}
docker-compose down
EOF
ssh ${DEPLOY_USER}@${DEPLOY_HOST} <<EOF
cd ${DEPLOY_DIRECTORY}
docker-compose up -d nginx-server
EOF

#!/usr/bin/env bash

which mvn > /dev/null || { echo "Maven not installed"; exit 1; }
which flutter > /dev/null || { echo "Flutter not installed"; exit 1; }

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REPO_ROOT_DIR=${SCRIPT_DIR}/../..
FLUTTER_BUILD_DIR=${REPO_ROOT_DIR}/build/web

cd ${REPO_ROOT_DIR}
flutter build web --base-href /registration-desk/

cd ${SCRIPT_DIR}
if [[ -d src ]]; then
  rm -rf src/
fi
mkdir -p src/main/resources/META-INF/resources/registration-desk
cp -r ${FLUTTER_BUILD_DIR}/* src/main/resources/META-INF/resources/registration-desk

mvn install

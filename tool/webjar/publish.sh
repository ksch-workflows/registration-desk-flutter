#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REPO_ROOT_DIR=${SCRIPT_DIR}/../..
FLUTTER_BUILD_DIR=${REPO_ROOT_DIR}/build/web

function usage()
{
    cat <<-END
usage: publish.sh -v VERSION [-l] [-h]

This script compiles the Flutter Web app, packages it
into a JAR file and then publishes it into a Maven repository.

required arguments:
  -v    The version number of the published package.

optional arguments:
  -l    Publish to Maven Local instead of the cloud repository.
  -h    Show this help message and exit.  
END
}

LOCAL_RELEASE="no"

while getopts "h l v:" o; do
  case "${o}" in
    v)
      VERSION=${OPTARG}
      ;;
    l)
      LOCAL_RELEASE="yes"
      ;;
    h | *)
      usage
      exit 0
      ;;
  esac
done
shift $((OPTIND-1))

if [[ -z "${VERSION}" ]] ; then
  echo "Missing required parameter for version."
  usage
  exit 1
fi

which flutter > /dev/null || { echo "ERROR: flutter not installed"; exit 1; }
which gradle > /dev/null || { echo "ERROR: gradle not installed"; exit 1; }

set -e

cd ${REPO_ROOT_DIR}
flutter test
flutter build web --base-href /registration-desk/

cd ${SCRIPT_DIR}
if [[ -d src ]]; then
  rm -rf src/
fi
mkdir -p src/main/resources/META-INF/resources/registration-desk
cp -r ${FLUTTER_BUILD_DIR}/* src/main/resources/META-INF/resources/registration-desk

PROPS="-Pversion=${VERSION}"
if [[ "${LOCAL_RELEASE}" == "yes" ]]; then
  gradle publishToMavenLocal $PROPS 
else
  echo "TODO: gradle publish $PROPS"
fi

#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REPO_ROOT_DIR=${SCRIPT_DIR}/../..
FLUTTER_BUILD_DIR=${REPO_ROOT_DIR}/build/web
APP_RESOURCE_TARGET_PATH="src/main/resources/META-INF/resources/registration-desk"

function usage()
{
    cat <<-END
usage: publish.sh -v VERSION [-l] [-b BASE_URL] [-h]

This script compiles the Flutter Web app, packages it
into a JAR file and then publishes it into a Maven repository.

required arguments:
  -v    The version number of the published package.

optional arguments:
  -l    Publish to Maven Local instead of the cloud repository.
  -b    The base URL for the HTTP requests.
  -h    Show this help message and exit.  
END
}

LOCAL_RELEASE="no"
BASE_URL="/"

while getopts "h l v: b:" o; do
  case "${o}" in
    v)
      VERSION=${OPTARG}
      ;;
    l)
      LOCAL_RELEASE="yes"
      ;;
    b)
      BASE_URL=${OPTARG}
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
if [[ "${LOCAL_RELEASE}" != "yes" ]] ; then
  flutter test
fi
flutter build web --base-href /registration-desk/ --dart-define="apiBaseUrl=${BASE_URL}"

cd ${SCRIPT_DIR}
if [[ -d src ]]; then
  rm -rf src/
fi
mkdir -p ${APP_RESOURCE_TARGET_PATH}
cp -r ${FLUTTER_BUILD_DIR}/* ${APP_RESOURCE_TARGET_PATH}

PROPS="-Pversion=${VERSION}"
if [[ "${LOCAL_RELEASE}" == "yes" ]] ; then
  gradle publishToMavenLocal ${PROPS}
else
  gradle publish ${PROPS}
fi

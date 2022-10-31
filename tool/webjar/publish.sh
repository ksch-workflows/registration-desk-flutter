#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REPO_ROOT_DIR=${SCRIPT_DIR}/../..
FLUTTER_BUILD_DIR=${REPO_ROOT_DIR}/build/web
PUBLISH_MAVEN_LOCAL="no"


function usage()
{
  echo "Compiles the Flutter Web app, packages it into a JAR files and then publishes it into a Maven repository."
  echo "./publish.sh"
  echo "\t-h --help"
  echo "\t-l --local"
  echo ""
}
# TODO Add support for passing in version number

while [ "$1" != "" ]; do
  PARAM=`echo $1 | awk -F= '{print $1}'`
  VALUE=`echo $1 | awk -F= '{print $2}'`
  case $PARAM in
    -h | --help)
      usage
      exit
      ;;
    -l | --local)
      PUBLISH_MAVEN_LOCAL="yes"
      ;;
    *)
      echo "ERROR: unknown parameter \"$PARAM\""
      usage
      exit 1
      ;;
  esac
  shift
done


cd ${REPO_ROOT_DIR}
flutter test
flutter build web --base-href /registration-desk/

cd ${SCRIPT_DIR}
if [[ -d src ]]; then
  rm -rf src/
fi
mkdir -p src/main/resources/META-INF/resources/registration-desk
cp -r ${FLUTTER_BUILD_DIR}/* src/main/resources/META-INF/resources/registration-desk

PROPS=""
if [[ "${PUBLISH_MAVEN_LOCAL}" == "yes" ]]; then
  # TODO set version number as Gradle property
  gradle publishToMavenLocal
else
  # TODO set version number as Gradle property
  gradle publish
fi

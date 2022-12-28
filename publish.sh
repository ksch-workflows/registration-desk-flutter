#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

docker compose run --rm mdbook build

read -p "Commit message: " message
git add .
git commit -m "$message"

git push

#!/usr/bin/env bash

set -e

HOST=`hostname`

if [ $HOST != "francis-lewis" ]; then
  echo "Invalid host"
  exit 0
fi

git fetch
git reset --hard origin/master

VERSION=$(grep -oP '(?<="version": ")[^"]+' < package.json)
echo "Setting APP_VERSION=${VERSION}"
sed --in-place -e "s/ENV =.*/ENV = {releaseStage: 'production', appVersion: '${VERSION}', bugsnagKey: '6a07b66124c696d0f685e1cf28312e41'};/" index.html

#!/bin/sh

if [ -d ./webos-metadata ]; then
CMAKE_SOURCE_DIR=./
fi

if [ -z $CMAKE_SOURCE_DIR ]; then
  echo 'Source dir not specified!'
  exit 1
fi

APP_META_DIR=$CMAKE_SOURCE_DIR/webos-metadata

PKG_NAME=$(jq -r .id ${APP_META_DIR}/appinfo.json)
EXE_NAME=$(jq -r .main ${APP_META_DIR}/appinfo.json)

DEVICE=hometv-nopass

ssh $DEVICE << EOF
killall ${EXE_NAME}
export APPID=${PKG_NAME}
cd apps/usr/palm/applications/${PKG_NAME}
if [ -f assets/debug.env ]; then
  source assets/debug.env
fi
# if [ -f assets/debug.args ]; then
# fi
strace ./${EXE_NAME} $DEBUG_ARGS
EOF
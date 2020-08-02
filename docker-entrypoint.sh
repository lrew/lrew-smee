#!/usr/bin/env sh

set -ex

SMEE_SERVICE_PATH=/var/lib/smee-client/service

if [ -z "${SMEE_SERVICE}" ];then
  if [ -f ${SMEE_SERVICE_PATH} ];then
    SMEE_SERVICE=`cat ${SMEE_SERVICE_PATH}`
  else
    SMEE_SERVICE=`curl -sI https://smee.io/new | grep Location | cut -d ' ' -f 2`
  fi
fi

if [ -z "${SMEE_SERVICE}" ];then
   rm -rf $SMEE_SERVICE_PATH

   exit 1
fi

mkdir -p /var/lib/smee-client
echo ${SMEE_SERVICE} > ${SMEE_SERVICE_PATH}

smee -u ${SMEE_SERVICE} -t ${SMEE_TARGET:-http://127.0.0.1:3000/}

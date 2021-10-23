#!/bin/sh

if [ ! "$(cat /etc/hosts | grep " ${DOMAIN_NAME}")" ]; then
  echo "** add ${DOMAIN_NAME} to /etc/hosts"
  echo "127.0.0.1    ${DOMAIN_NAME}" >> /etc/hosts
fi

#!/bin/bash

# Userspace setup and startup
if [ ! -e /data/startup.sh ] ; then
  cp ~/startup.sh.user /data/startup.sh
  chmod 754 /data/startup.sh
fi

/data/startup.sh

#!/bin/bash

if [ ! -e /data/.jupyter/jupyter_notebook_config.py ] ; then
  cp -R ~/.jupyter/jupyter_notebook_config.py /data
fi

#jupyter lab

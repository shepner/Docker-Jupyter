# reference:
# sudo docker build https://github.com/shepner/Docker-Jupyter.git

###########################################################################################
FROM ubuntu:latest

USER root

###########################################################################################
# general settings
ENV TERM=xterm
  
###########################################################################################
# user setup
ENV \
  PUSR=docker \
  ARG_PUID=1003 \
  ARG_PGID=1100
ENV HOME="/$PUSR"

# set the default values we will use
ARG PUID=$ARG_PUID
ARG PGID=$ARG_PGID

# create the group, user, and home dir
RUN \
  groupadd -r -g $PGID $PUSR \
  && useradd -r -b / -d $HOME -m -u $PUID -g $PGID -s /bin/bash $PUSR
  
###########################################################################################
# setup the home directory and scripts
#RUN mkdir -p $HOME/.jupyter

COPY src/jupyter_notebook_config.py.orig $HOME/.jupyter/jupyter_notebook_config.py.orig
COPY src/startup.* $HOME/

RUN \
  chmod 554 $HOME/startup.* \
  && chown -R $PUID:$PGID $HOME

###########################################################################################
# setup the working directory
ENV DATA_DIR="/data"

RUN \
  mkdir -p $DATA_DIR \
  && chown -R $PUID:$PGID $DATA_DIR

VOLUME [$DATA_DIR]

###########################################################################################
# Install prerequisites
RUN \
  apt-get -q update \
  && apt-get install -qy apt-utils \
                         software-properties-common

###########################################################################################
# System update
RUN \
  apt-get -q update \
  && apt-get -qy upgrade \
  && apt-get -qy dist-upgrade

###########################################################################################
# general utils
RUN \
  apt-get -q update \
  && apt-get install -qy wget \
                         git

###########################################################################################
# Jupyter dependancies
RUN \
  apt-get -q update \
  && apt-get install -qy python3 \
                         python3-pip \
                         nodejs \
                         npm

###########################################################################################
# installation cleanup
RUN \
  apt-get -q update \
  && apt-get -qy autoclean \
  && apt-get -qy autoremove \
  && rm -rf /var/lib/apt/lists/* \
            /tmp/* \
            /var/tmp/*

###########################################################################################
# startup tasks
USER $PUSR:$PGID

WORKDIR $DATA_DIR

CMD $HOME/startup.sh

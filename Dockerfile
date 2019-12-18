# reference:
# sudo docker build https://github.com/shepner/Docker-Jupyter.git

###########################################################################################
FROM ubuntu:latest

USER root

###########################################################################################
# general settings
ENV TERM=xterm
ENV DATA_DIR="/data"
  
###########################################################################################
# user setup
ENV PUSR=docker

ENV HOME="/$PUSR"

# set the default values we will use
ARG ARG_PUID=1003
ARG ARG_PGID=1100

# These now can be changed from `docker run -e [...]`
ENV \ 
  PUID=$ARG_PUID \
  PGID=$ARG_PGID
  
RUN \
  groupadd -r -g $PGID $PUSR \
  && useradd -r -b / -d $HOME -m -u $PUID -g $PGID -s /bin/bash $PUSR \
  && mkdir -p $HOME \
  && chown -R $PUID:$PGID $HOME

###########################################################################################
# Install prerequisites
RUN \
  apt-get -q update \
  && apt-get install -qy apt-utils \
                         software-properties-common

###########################################################################################
# Update base packages
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
  apt-get -qy autoclean \
  && apt-get -qy autoremove \
  && rm -rf /var/lib/apt/lists/*

###########################################################################################
###########################################################################################
###########################################################################################
# Everything here on is local user only
USER $PUSR:$PGID

###########################################################################################
# Jupyter
RUN \
  pip3 install jupyterlab \
               ipywidgets

# Jupyter configs go here
VOLUME [$HOME]

# User data goes here
VOLUME [$DATA_DIR]

# update the path so Jupyter will work
ENV PATH="/usr/local/bin/:${PATH}"

##########
# Addons

#[Getting Started with Plotly in Python](https://plot.ly/python/getting-started/)
RUN pip3 install plotly
ENV NODE_OPTIONS="--max-old-space-size=4096"
#RUN \
#  /usr/local/bin/jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build \
#  && /usr/local/bin/jupyter labextension install jupyterlab-plotly --no-build \
#  && /usr/local/bin/jupyter labextension install plotlywidget --no-build \
#  && /usr/local/bin/jupyter labextension install jupyterlab-chart-editor --no-build
ENV NODE_OPTIONS=

#https://blog.jupyter.org/99-ways-to-extend-the-jupyter-ecosystem-11e5dab7c54
#
#https://jupyterlab.readthedocs.io/en/stable/user/extensions.html
#to show what kernels are installed:  `jupyter kernelspec list`

#https://github.com/NII-cloud-operation/sshkernel
#RUN \
#  pip3 install sshkernel \
#  && python3 -m sshkernel install

#https://github.com/takluyver/bash_kernel
#RUN \
#  pip3 install bash_kernel \
#  && python3 -m bash_kernel.install

#https://github.com/jupyter/jupyter/wiki/Jupyter-kernels
#https://vatlab.github.io/sos-docs/
#https://github.com/vatlab/SOS
#RUN \
#  pip3 install sos \
#               sos-notebook \
#  && python3 -m sos_notebook.install \
#  && /usr/local/bin/jupyter labextension install transient-display-data --no-build \
#  && /usr/local/bin/jupyter labextension install jupyterlab-sos --no-build

#https://github.com/jupyterlab/jupyterlab-toc
#RUN /usr/local/bin/jupyter labextension install @jupyterlab/toc --no-build

#https://github.com/jtpio/jupyterlab-topbar
# container extension
#RUN jupyter labextension install jupyterlab-topbar-extension --no-build
# system metrics
#RUN \
#  jupyter labextension install jupyterlab-system-monitor --no-build \
#  && pip3 install nbresuse
# custom text in the top bar
#RUN jupyter labextension install jupyterlab-topbar-text --no-build
# add a logout button
#RUN jupyter labextension install jupyterlab-logout --no-build
# theme toggling extension
#RUN jupyter labextension install jupyterlab-theme-toggle --no-build

#https://github.com/QuantStack/jupyterlab-drawio
#RUN /usr/local/bin/jupyter labextension install jupyterlab-drawio --no-build

#https://github.com/IBM/jupyterlab-s3-browser
#https://github.com/danielfrg/s3contents
#https://github.com/timkpaine/multicontentsmanager

#open web pages from the Jupyter server(!)
#https://github.com/timkpaine/jupyterlab_iframe/
#https://github.com/jupyterlab/jupyterlab/issues/6235
#RUN \
#  pip3 install jupyterlab_iframe \
#  && jupyter labextension install jupyterlab_iframe --no-build \
#  && jupyter serverextension enable --py jupyterlab_iframe
#optional: run the following to get a list of sites in the sidebar:
#cat << EOM >> jupyter_notebook_config.py
##c.JupyterLabIFrame.iframes = ['list', 'of', 'sites']
##c.JupyterLabIFrame.welcome = 'a site'
#EOM


##########
# Themes

#https://github.com/oriolmirosa/jupyterlab_materialdarker
#RUN jupyter labextension install @oriolmirosa/jupyterlab_materialdarker --no-build
# https://github.com/telamonian/theme-darcula
#RUN jupyter labextension install @telamonian/theme-darcula --no-build
#https://github.com/Rahlir/theme-gruvbox
#RUN /usr/local/bin/jupyter labextension update @rahlir/theme-gruvbox


##########
# build the config
#RUN /usr/local/bin/jupyter lab build

###########################################################################################
# Python libs
RUN \
  pip3 install numpy \
               pandas \
               boto3 \
               requests \
               pyyaml \
               fabric

#[ruamel.yaml](https://yaml.readthedocs.io/en/latest/install.html)
RUN \
  pip3 install setuptools \
               ruamel.yaml

#needed for one specific test app
RUN \
  pip3 install numpy \
               flask \
               huey \
               micawber \
               peewee \
               redis \
               markdown \
               flask_peewee \
               beautifulsoup4

###########################################################################################
# startup tasks
WORKDIR $DATA_DIR

#ENTRYPOINT ["/usr/local/bin/jupyter", "%s"] # pass all commandline params to `docker run <container>` to this
#CMD ["lab"] # use these params by default
CMD ["/bin/sh"]

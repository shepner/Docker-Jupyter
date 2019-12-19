###########################################################################################

##########
# Addons

#[Getting Started with Plotly in Python](https://plot.ly/python/getting-started/)
pip3 install plotly
NODE_OPTIONS="--max-old-space-size=4096"
jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
jupyter labextension install jupyterlab-plotly --no-build
jupyter labextension install plotlywidget --no-build
jupyter labextension install jupyterlab-chart-editor --no-build
ENV NODE_OPTIONS=

#https://blog.jupyter.org/99-ways-to-extend-the-jupyter-ecosystem-11e5dab7c54
#
#https://jupyterlab.readthedocs.io/en/stable/user/extensions.html
#to show what kernels are installed:  `jupyter kernelspec list`

#https://github.com/NII-cloud-operation/sshkernel
pip3 install sshkernel
python3 -m sshkernel install

#https://github.com/takluyver/bash_kernel
pip3 install bash_kernel
python3 -m bash_kernel.install

#https://github.com/jupyter/jupyter/wiki/Jupyter-kernels
#https://vatlab.github.io/sos-docs/
#https://github.com/vatlab/SOS
pip3 install sos \
             sos-notebook
python3 -m sos_notebook.install
jupyter labextension install transient-display-data --no-build
jupyter labextension install jupyterlab-sos --no-build

#https://github.com/jupyterlab/jupyterlab-toc
jupyter labextension install @jupyterlab/toc --no-build

#https://github.com/jtpio/jupyterlab-topbar
# container extension
#jupyter labextension install jupyterlab-topbar-extension --no-build
# system metrics
#jupyter labextension install jupyterlab-system-monitor --no-build
#pip3 install nbresuse
# custom text in the top bar
#jupyter labextension install jupyterlab-topbar-text --no-build
# add a logout button
#jupyter labextension install jupyterlab-logout --no-build
# theme toggling extension
#jupyter labextension install jupyterlab-theme-toggle --no-build

#https://github.com/QuantStack/jupyterlab-drawio
jupyter labextension install jupyterlab-drawio --no-build

#https://github.com/IBM/jupyterlab-s3-browser
#https://github.com/danielfrg/s3contents
#https://github.com/timkpaine/multicontentsmanager

#open web pages from the Jupyter server(!)
#https://github.com/timkpaine/jupyterlab_iframe/
#https://github.com/jupyterlab/jupyterlab/issues/6235
#pip3 install jupyterlab_iframe
#jupyter labextension install jupyterlab_iframe --no-build
#jupyter serverextension enable --py jupyterlab_iframe
#optional: run the following to get a list of sites in the sidebar:
#cat << EOM >> jupyter_notebook_config.py
##c.JupyterLabIFrame.iframes = ['list', 'of', 'sites']
##c.JupyterLabIFrame.welcome = 'a site'
#EOM


##########
# Themes

#https://github.com/oriolmirosa/jupyterlab_materialdarker
#jupyter labextension install @oriolmirosa/jupyterlab_materialdarker --no-build
# https://github.com/telamonian/theme-darcula
#jupyter labextension install @telamonian/theme-darcula --no-build
#https://github.com/Rahlir/theme-gruvbox
jupyter labextension update @rahlir/theme-gruvbox


##########
# build the config
jupyter lab build

###########################################################################################
# Python libs
pip3 install numpy \
             pandas \
             boto3 \
             requests \
             pyyaml \
             fabric

#[ruamel.yaml](https://yaml.readthedocs.io/en/latest/install.html)
pip3 install setuptools \
             ruamel.yaml

#needed for one specific test app
pip3 install numpy \
             flask \
             huey \
             micawber \
             peewee \
             redis \
             markdown \
             flask_peewee \
             beautifulsoup4

# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
# Updated from https://github.com/jupyter/docker-stacks/blob/master/datascience-notebook/Dockerfile

FROM jupyter/scipy-notebook:281505737f8a

MAINTAINER Jupyter Project <jupyter@googlegroups.com>

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    nano \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER

#Jason Added
RUN conda install -c conda-forge --quiet --yes \
    'fastparquet=0.1*' \
    'nbpresent=3.0*' \
    'ipython_unittest=0.2*' \
    'ruamel.yaml=0.15*'
RUN conda install --quiet --yes  \
    'pandas-datareader=0.5*' \
    'beautifulsoup4=4.6*' 

# R packages including IRKernel which gets installed globally.
RUN conda config --system --add channels r && \
    conda install --quiet --yes \
    'rpy2=2.8*' \
    'r-base=3.3.2' \
    'r-irkernel=0.7*' \
    'r-plyr=1.8*' \
    'r-devtools=1.12*' \
    'r-tidyverse=1.0*' \
    'r-shiny=0.14*' \
    'r-rmarkdown=1.2*' \
    'r-forecast=7.3*' \
    'r-rsqlite=1.1*' \
    'r-reshape2=1.4*' \
    'r-nycflights13=0.2*' \
    'r-caret=6.0*' \
    'r-rcurl=1.95*' \
    'r-crayon=1.3*' \
    'r-randomforest=4.6*' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR
#add twitter
RUN /opt/conda/bin/pip install twitter==1.17.1
RUN conda install -c conda-forge --quiet --yes \
    'plotly=2.0*'
ARG JUPYTERHUB_VERSION=0.8
RUN pip install --no-cache jupyterhub==$JUPYTERHUB_VERSION

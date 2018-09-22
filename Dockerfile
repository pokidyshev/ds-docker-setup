# Source: https://github.com/ufoym/deepo
# ==================================================================
# module list
# ------------------------------------------------------------------
# python        3.6    (apt)
# jupyter       latest (pip)
# pytorch       latest (pip)
# tensorflow    latest (pip)
# keras         latest (pip)
# ==================================================================

FROM ubuntu:16.04
RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \
    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && \
# ==================================================================
# tools
# ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        apt-utils \
        build-essential \
        ca-certificates \
        cmake \
        wget \
        curl \
        git \
        vim \
        && \
# ==================================================================
# python
# ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        software-properties-common \
        && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python3.6 \
        python3.6-dev \
        && \
    wget -O ~/get-pip.py \
        https://bootstrap.pypa.io/get-pip.py && \
    python3.6 ~/get-pip.py && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python && \
    $PIP_INSTALL \
        setuptools \
        && \
    $PIP_INSTALL \
        numpy \
        scipy \
        pandas \
        scikit-learn \
        matplotlib \
        Cython \
        && \
# ==================================================================
# jupyter
# ------------------------------------------------------------------
    $PIP_INSTALL \
        jupyter \
        jupyterlab \
        ipywidgets \
        && \
# ==================================================================
# tensorflow
# ------------------------------------------------------------------
    $PIP_INSTALL \
        tensorflow \
        tensorboard \
        && \
# ==================================================================
# pytorch
# ------------------------------------------------------------------
    $PIP_INSTALL \
        torch \
        torchvision \
        tensorboardX  \
        && \
# ==================================================================
# keras
# ------------------------------------------------------------------
    $PIP_INSTALL \
        h5py \
        keras \
        keras-tqdm \
        livelossplot \
        && \
# ==================================================================
# boosting
# ------------------------------------------------------------------
    $PIP_INSTALL \
        catboost \
        lightgbm \
        xgboost \
        && \
# ==================================================================
# NLP
# ------------------------------------------------------------------
    $PIP_INSTALL \
        spacy \
        pymorphy2 \      
        pymystem3 \
        gensim \
        && \
# ==================================================================
# ML
# ------------------------------------------------------------------
    $PIP_INSTALL \
        fbprophet \
        imgaug \
        kaggle \
        seaborn \
        && \
# ==================================================================
# misc
# ------------------------------------------------------------------
    $PIP_INSTALL \
        stringcase \
        Pillow \    
        requests \        
        scikit-image \
        sympy \           
        tqdm \
        && \
# ==================================================================
# config & cleanup
# ------------------------------------------------------------------
    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/* \
    && \
# ==================================================================
# Jupyter lab tweaks
# ------------------------------------------------------------------
    $PIP_INSTALL \
        jupyterlab-git \
        jupyter-tensorboard \
        && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && $APT_INSTALL nodejs && \
    jupyter labextension install @jupyterlab/toc && \
    jupyter labextension install @jupyterlab/git && jupyter serverextension enable --py jupyterlab_git && \
    jupyter labextension install jupyterlab_tensorboard
    
EXPOSE 8888 6006

CMD ["sh", "-c", "jupyter lab --port=9999 --no-browser --ip=0.0.0.0 --allow-root"]

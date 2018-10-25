FROM nvidia/cuda:9.0-cudnn7-runtime
RUN rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update
# ==================================================================
# tools
# ------------------------------------------------------------------
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        cmake \
        htop \
        wget \
        curl \
        git \
        vim \
        zip \
        unzip
# ==================================================================
# python
# ------------------------------------------------------------------
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        software-properties-common \
        && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        python3.6 \
        python3.6-dev \
        && \
    wget -O ~/get-pip.py https://bootstrap.pypa.io/get-pip.py && \
    python3.6 ~/get-pip.py && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python && \
    python -m pip --no-cache-dir install --upgrade \
        setuptools \
        && \
    python -m pip --no-cache-dir install --upgrade \
        numpy \
        scipy \
        pandas \
        scikit-learn \
        matplotlib \
        Cython
# ==================================================================
# jupyter
# ------------------------------------------------------------------
RUN python -m pip --no-cache-dir install --upgrade \
        jupyter \
        jupyterlab \
        ipywidgets \
        jupyterlab-git \
        jupyter-tensorboard \
        && \
    # install Node.js
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends nodejs && \
    # install labextensions
    jupyter labextension install \
        @jupyterlab/toc \
        @jupyterlab/git \ 
        # jupyterlab_tensorboard \
        && \
    jupyter serverextension enable --py jupyterlab_git && \
    # Fix issue with tqdm_notebook not showing widgets
    jupyter nbextension enable --py widgetsnbextension && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager
# ==================================================================
# pytorch & fast.ai
# ------------------------------------------------------------------
# RUN python -m pip --no-cache-dir install --upgrade \
        # http://download.pytorch.org/whl/cu80/torch-0.3.1-cp36-cp36m-linux_x86_64.whl \
        # torchvision \
        # && \
RUN python -m pip --no-cache-dir install --upgrade \
        git+https://github.com/fastai/fastai.git \
        # fast.ai dependecy
        opencv-python \
        tensorboardX \
        && \
    # fast.ai dependecies
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        libsm6 libxext6 libxrender-dev
# ==================================================================
# tensorflow & keras
# ------------------------------------------------------------------
RUN python -m pip --no-cache-dir install --upgrade \
        tensorflow-gpu \
        && \
    python -m pip --no-cache-dir install --upgrade \        
        h5py \
        keras \
        keras-tqdm \
        livelossplot
# ==================================================================
# boosting
# ------------------------------------------------------------------
RUN python -m pip --no-cache-dir install --upgrade \
    catboost \
    lightgbm \
    xgboost \
    shap
# ==================================================================
# NLP
# ------------------------------------------------------------------
RUN python -m pip --no-cache-dir install --upgrade \
        nltk \
        spacy \
        pymorphy2 \      
        pymystem3 \
        gensim \
        && \
    # setup nltk
    python -c "import nltk; nltk.download('stopwords'); nltk.download('punkt')"
# ==================================================================
# ML
# ------------------------------------------------------------------
RUN python -m pip --no-cache-dir install --upgrade \
        fbprophet \
        imgaug \
        kaggle \
        seaborn \
        pip install -U git+https://github.com/albu/albumentations
# ==================================================================
# misc
# ------------------------------------------------------------------
RUN python -m pip --no-cache-dir install --upgrade \
        stringcase \
        Pillow \    
        requests \        
        scikit-image \
        sympy \           
        tqdm \
        rawpy \
        hyperopt 
# ==================================================================
# config & cleanup
# ------------------------------------------------------------------
RUN ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

EXPOSE 9999 6006

CMD ["sh", "-c", "jupyter lab --port=9999 --no-browser --ip=0.0.0.0 --allow-root"]

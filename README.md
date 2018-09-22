# Docker for Data Science

This repo contains scripts to run Jupyter (and install all DS libs) on a remote docker container.

# How to use this code

1. Make sure you have installed [NVIDIA driver](https://github.com/NVIDIA/nvidia-docker/wiki/Frequently-Asked-Questions#how-do-i-install-the-nvidia-driver) and [nvidia-docker](https://github.com/NVIDIA/nvidia-docker)
2. Set up the connection with remote server. For example: ```ssh -L <host port>:localhost:<remote port> user@remote```
3. Clone repo to the remote and run `build.sh` and `run.sh` respectively.

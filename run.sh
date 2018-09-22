#!/bin/bash
nvidia-docker run -d --ipc=host -it -p 9999:9999 -v /home/npokidyshev/:/my -v /opt/shared/:/shared --name sandpiturtle_lab my/deepo

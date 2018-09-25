#!/bin/bash
nvidia-docker run -d --ipc=host -it -p 9999:9999 -v /home/npokidyshev/:/my -v /opt/:/opt --name sandpiturtle_lab sandpiturtle/lab

#!/bin/bash
nvidia-docker run -dit --restart unless-stopped --ipc=host -p 9999:9999 -v /home/npokidyshev/:/my -v /opt/:/opt -v /mnt:/mnt --name sandpiturtle_lab sandpiturtle/lab

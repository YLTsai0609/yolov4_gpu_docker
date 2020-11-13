# Installation

## Docker

`sh shell_scripts/docker_install.sh`

Validate your docker installation by `docker -v`.

## Nvidia-docker2

It is the software make your docker container be able to aceess GPU.

Make sure you have installed nvidia-driver by `nvidia-smi`.

Then run :

`sh shell_scripts/nvidia-docker_install.sh`

to install nvidia-docker2.

Validate nvidia-docker2 by 

`sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi`.

## Build yolov4-gpu docker image

Make sure you are in the folder `yolov4_gpu_docker`.

Then run : 

`docker build --tag yolov4-gpu .`

# Usage

1. Run the container

`docker run -it --runtime=nvidia --shm-size=1g -d --name yolov4-gpu yolov4-gpu`

2. Get the shell

`docker exec -it yolov4-gpu /bin/bash`

3. Test prediction

`./darknet detector test cfg/coco.data cfg/yolov4.cfg yolov4.weights -ext_output data/dog.jpg`

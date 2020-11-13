FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

ENV DEBIAN_FRONTEND noninteractive
ENV DARKNET_PATH /darknet
# compiler
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential=12.* \
    ca-certificates=* \
    curl=7.58.* \
    g++=4:7.* \
    gcc=4:7.* \
  && rm -rf /var/lib/apt/lists/*

# python and python package
RUN apt-get update -y && apt-get install -y python3-pip python3-dev libsm6 libxext6 libxrender-dev

# command line tools
RUN \
        apt-get install -y \
        wget \
        unzip \
        ffmpeg \
        git \
	vim

# if you wanna set up the docker volume 
RUN mkdir /output

RUN git clone --depth 1 https://github.com/AlexeyAB/darknet.git

WORKDIR /darknet

RUN sed -i 's/GPU=.*/GPU=1/' Makefile 
RUN sed -i 's/LIBSO=.*/LIBSO=1/' Makefile
RUN make

RUN curl -sSLO https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.weights


# validate installation
CMD ./darknet detector test cfg/coco.data yolov4.cfg yolov4.weights -ext_output data/dog.jpg

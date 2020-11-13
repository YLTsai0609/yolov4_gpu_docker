# based on official documentation
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker
# date 2020 Nov 12

# setting up NVIDIA Container Toolkit

distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# install nvidia-docker2 package and dependencies adter updating

sudo apt-get update

sudo apt-get install -y nvidia-docker2

# restart docker daemon

sudo systemctl restart docker

# test by running a base CUDA container

sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi

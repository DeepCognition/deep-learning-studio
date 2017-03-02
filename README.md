# deep-learning-studio
GUI based deep learning platform

This repository contains installer for Deep Learning Studio Home Edition. Deep Learning Studio Home Edition is provided for *FREE* for *NON-COMMERCIAL* use.

For commercial and enterprise license, please contact hello@deepcognition.ai.

Requirements for Deep Learning Studio Home Edition:

1. Ubuntu 16.04 (other varients may work but not tested)

2. Docker - 
  a. install docker using steps mentioned at https://docs.docker.com/engine/installation/linux/ubuntu/
  b. Add your username in docker group as mentioned in https://docs.docker.com/engine/installation/linux/linux-postinstall/

3. Nvidia-docker (Optional)
  a. if you system contains Nvidia GPU, you can install nvidia-docker to accelerate training.
  b. Follow the installation instruction at https://github.com/NVIDIA/nvidia-docker/wiki/Installation
  c. Install Nvidia Driver version 367.57 or newer
  

**Installation Steps:**

1. Download dls.sh script and apply the execute permission:
  a. chmod +x dls.sh

2. Download the deep learning studio home edition image
  a. ./dls.sh update
  b. Wait till download is finished
  

**Running Deep Learning Studio**

1. To start deep learning studio, type following:
  a. ./dls.sh -p <port number> -d /absolute/path/to/data/fodler run
  b. In your browser type the URL as showed by the above command.
  c. Sign up for an user account at deepcognition to start using deep learning studio
  
2. To stop deep learning studio
  a. ./dls.sh stop
  
**Limitations in Home Edition version:**

1. Home edition is limited to personal and acedemic research use.
2. Home edition is limited to Single User and Single GPU.
3. No dedicated support. If you are facing any issue in using the software, you can file the issue in this github project.

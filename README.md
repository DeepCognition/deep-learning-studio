# deep-learning-studio
GUI based deep learning platform

This repository contains installer for Deep Learning Studio Personal Edition. Deep Learning Studio Personal Edition is provided for *FREE* for *NON-COMMERCIAL* use.

For commercial and enterprise license, please contact hello@deepcognition.ai.

**Requirements for Deep Learning Studio Personal Edition:**

1. Ubuntu 16.04 (other varients may work but not tested)

2. Docker - 
  - install docker using steps mentioned at https://docs.docker.com/engine/installation/linux/ubuntu/
  - Add your username in docker group as mentioned in https://docs.docker.com/engine/installation/linux/linux-postinstall/

3. Nvidia-docker (Optional)
  - if you system contains Nvidia GPU, you can install nvidia-docker to accelerate training.
  - Follow the installation instruction at https://github.com/NVIDIA/nvidia-docker/wiki/Installation
  - Install Nvidia Driver version 367.57 or newer
  

**Installation Steps:**

1. Download dls.sh script and apply the execute permission:
  - chmod +x dls.sh

2. Download the deep learning studio home edition image
  - ./dls.sh update
  - Wait till download is finished
  

**Running Deep Learning Studio**

1. To start deep learning studio, type following:
  - ./dls.sh -p `<port number>` -d /absolute/path/to/data/folder run
  - In your browser type the URL as showed by the above command.
  - Sign up for an user account at deepcognition to start using deep learning studio
  
2. To stop deep learning studio
  - ./dls.sh stop
  
**Limitations in Personal Edition version:**

1. Personal edition is limited to personal and acedemic research use.
2. Personal edition is limited to Single User and Single GPU.
3. No dedicated support. If you are facing any issue in using the software, you can file the issue in this github project.

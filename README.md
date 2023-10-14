# ObVi-SLAM Evaluation

## Overview

In the evaluation, we compared ObVi-SLAM against [ORB-SLAM3](https://github.com/UZ-SLAMLab/ORB_SLAM3), [OA-SLAM](https://gitlab.inria.fr/tangram/oa-slam), and [DROID-SLAM](https://github.com/princeton-vl/DROID-SLAM). We used the `ObViSLAMEvaluation` branch from research dev fork of them under [ORB-SLAM3](https://github.com/ut-amrl/ORB_SLAM3/tree/ObViSLAMEvaluation), [OA-SLAM](https://github.com/ut-amrl/oa-slam/tree/ObViSLAMEvaluation), and [DROID-SLAM](https://github.com/ut-amrl/DROID-SLAM/tree/ObViSLAMEvaluation). DROID-SLAM uses conda to set up its environment; For ORB-SLAM3 and OA-SLAM, we provide our docker setup inside `ros-noetic-docker`.


## Docker Setup

You can follow the installation and running instructions given by ORB-SLAM3, OA-SLAM, and DROID-SLAM. You can find We also provide our docker setup. It requires the [Docker Engine](https://docs.docker.com/engine/install/ubuntu), [Docker Compose](https://docs.docker.com/compose/install/linux/), and [Nvidia Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html). `ros-noetic-docker` contains separate docker files for ORB-SLAM3 and OA-SLAM. For DROID-SLAM, we used conda to set up the environment (see the `ObViSLAMEvaluation` branch from our research dev fork of [DROID-SLAM](https://github.com/ut-amrl/DROID-SLAM/tree/ObViSLAMEvaluation)) If you'd like to use our evaluation scripts to run the experiment, use Dockerfile under `obvislam-eval`, which handles environemnt setup for ORB-SLAM3, OA-SLAM, and DROID-SLAM.

To build the docker image:
```Bash
./build.py obvislam-eval
```

Now, we need to mount necessary files. In our convenient scripts, we assume the project is mounted under `/root/ObVi-SLAM-Evaluation` and the data are mounted under `/root/ObVi-SLAM-Evaluation/data`. To mount files, specify the followings inside the volume session of `ros-noetic-docker/noetic/obvislam-eval/compose.yaml`:
```YAML
volumes:
      - <path_to_ObVi-SLAM-Evaluation_root_dir>:/root/ObVi-SLAM-Evaluation
      - <path_to_data_root_dir>:/root/ObVi-SLAM-Evaluation/data
```
This will mount the entire folders under `<path_to_ObVi-SLAM-Evaluation_root_dir>` and `<path_to_data_root_dir>` to the container. To be safer, you can specify the read/write permission for different subfolders. For example:
```YAML
volumes:
      - <path_to_ObVi-SLAM-Evaluation_root_dir>:/root/ObVi-SLAM-Evaluation
      - <path_to_data_root_dir>:/root/ObVi-SLAM-Evaluation/data/original_data:ro
      - <path_to_data_root_dir>:/root/ObVi-SLAM-Evaluation/data/oa_slam_in:ro
      - <path_to_data_root_dir>:/root/ObVi-SLAM-Evaluation/data/oa_slam_out
      - ...
```

To lanuch the docker container:
```Bash
./launch.py obvislam-eval
```
You can verify the container is running by `docker ps`. You should see a container running with the name `${YOUR_USERNAME}-noetic-obvislam-eval-app-1`.

To start a shell session as the root user"
```Bash
docker exec -it -u root $USER-noetic-obvislam-eval-app-1 $SHELL
```

You need to run `source /.dockerenv` to set up environmental variables properly inside the container. Alternatively, you can also refer to this solution [here](https://github.com/ut-amrl/ros-noetic-docker#environment-setup).

You can exit from the session through `Ctrl-D`. You can stop the container by:
```Bash
docker stop $USER-noetic-obvislam-eval-app-1
```

## Running DROID-SLAM
See the [DROID-SLAM](https://github.com/ut-amrl/DROID-SLAM/tree/ObViSLAMEvaluation) page.

## Running ORB-SLAM3
The `ObViSLAMEvaluation` relies on the [amrl_msgs](https://github.com/ut-amrl/amrl_msgs/tree/orbSlamSwitchTraj) to save trajectories. To install this package:
```Bash
git clone https://github.com/ut-amrl/amrl_msgs.git
cd amrl_msgs
git checkout objectDetectionMsgs # Or the orbSlamSwitchTraj branch
export ROS_PACKAGE_PATH=`pwd`:$ROS_PACKAGE_PATH
make
```
See the [ORB-SLAM3](https://github.com/ut-amrl/ORB_SLAM3/tree/ObViSLAMEvaluation) page for further instructions.

## Object Detector
Object detector is neccessary to run any object-SLAM algorithms including ObVi-SLAM and OA-SLAM. We relied on [YOLOV5](https://github.com/ultralytics/yolov5) and fine-tuned a model for object detection. You can refer to its README page to set up YOLOv5. Refer to our [YOLOv5 page](https://github.com/ut-amrl/yolov5/blob/ROS/README.md) for the ROS object detector setup. You can download a fine-tuned model [here](https://drive.google.com/file/d/1aMkPj4NEWnSGbPKYld_6dnm9TSgYZwzR/view?usp=sharing) that detects the four following classes: treetrunks, trashcans, lampposts, and benches. To run the detector for the evaluation:
```Bash
python detect_ros.py --weights <path_to_weight_file>  --img 960 --conf 0.2
```

## Running OA-SLAM
See the [OA-SLAM](https://github.com/ut-amrl/OA-SLAM/tree/ObViSLAMEvaluation) page. 

## Running ObVi-SLAM
See the [ObVi-SLAM](https://github.com/ut-amrl/ObVi-SLAM) page.

<!-- export LD_LIBRARY_PATH=/usr/local/lib/python3.8/dist-packages/nvidia/cudnn/lib:$LD_LIBRARY_PATH -->

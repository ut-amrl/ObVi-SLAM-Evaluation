# TODOS
* Add LeGO-LOAM repo
* Make filesystem consistent between docker & podman

# Docker Usage

## Submodules
Init submodules:
```
git submodule update --init --recursive
```
Update submodules:
```
git submodule update --remote
```
Check all submodules are updated to the correct branches:
```
git submodule status
```
Should see the following branches:
* OA-SLAM (remotes/origin/stereo/feature_stereo)
* ORB_SLAM2 (remotes/origin/writeTimestamps)
* ORB_SLAM3 (remotes/origin/amandaMultisession)
* amrl_msgs (remotes/origin/orbSlamSwitchTraj)
* ros-noetic-docker (heads/taijing/ltov-slam/dev)
* ut_vslam (heads/docker/test)
* yolov5-ros (heads/master)

## File Structure
Currently, the scripts assume that you have a file structure like following when you mount your data:
```
${HOME}/data/calibration
${HOME}/data/lego_loam_out (going to be redundant after adding LeGO-LOAM)
${HOME}/data/yolo_models
${HOME}/data/original_data
```

## Docker
Check the README page of `ros-noetic-docker` for docker installation details. In `ros-noetic-docker/noetic/ltov-slam/compose.yaml`, make sure you have correct paths in "volumes". For example, if your data directory is under `my-data-dir`, change the default path to `my-data-dir:/home/${CONTAINER_USER}/data`.
 
To log-in to the `docker` group:
```
newgrp docker
```
Inside `ros-noetic-docker`, build the docker image by:
```
./build.py ltov-slam
```
Launch docker container:
```
./launch.py ltov-slam
```
Start a shell inside the container: 
```
docker exec -it $USER-noetic-ltov-slam-app-1 $SHELL
```
Stop docker:
```
docker stop $USER-noetic-ltov-slam-app-1
```

## ROS
Run ROS inside the container

# Podman Usage

## Repository setup
Clone the `podman` branch of the repository:
```
git clone --recursive -b podman https://github.com/ut-amrl/LTOV-SLAM-Evaluation.git
```
`git submodule status` should give you the following branches
* OA-SLAM (remotes/origin/stereo/feature_stereo)
* ORB_SLAM2 (remotes/origin/writeTimestamps)
* ORB_SLAM3 (remotes/origin/amandaMultisession)
* amrl_msgs (remotes/origin/orbSlamSwitchTraj)
* ros-noetic-docker (heads/taijing/ltov-slam/podman)
* ut_vslam (heads/docker/test)
* yolov5-ros (heads/master)

## File Structure
Currently, the scripts assume that you have a file structure like following when you mount your data:
```
/root/LTOV-SLAM-Evaluation/data/calibration
/root/LTOV-SLAM-Evaluation/data/lego_loam_out (going to be redundant after adding LeGO-LOAM)
/root/LTOV-SLAM-Evaluation/data/yolo_models
/root/LTOV-SLAM-Evaluation/data/original_data
```

## Podman
First, refer to the podman website for podman installation in. You also need to install [podman-compose](https://github.com/containers/podman-compose), which can be installed in a vm. Unlike the `docker` branch, currently this branch assumes you have CDI support from the [NVIDIA CONTAINER TOOLKIT for podman](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#id9). In `ros-noetic-docker/noetic/ltov-slam-podman/compose.yaml`, make sure you have correct paths in "volumes".

Pull docker image to podman (select `docker.io:tiejean/tiejean/noetic-ltov-slam:evaluation` if you're prompted):
```
podman pull tiejean/noetic-ltov-slam:evaluation
```

Launch container:
```
./launch_podman.py ltov-slam-podman
```

Start a new terminal as the container root (Note that unlike docker, it's important that you run as container's root; Otherwise you may encounter permission problem):
```
podman exec -it -u root ltov-slam-podman_app_1 $SHELL
```

Stop container:
```
ltov-slam-podman_app_1
```

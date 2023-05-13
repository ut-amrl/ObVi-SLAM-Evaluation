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

## Podman
First, refer to the podman website for podman installation in. Unlike the `docker` branch, currently this branch assumes you have CDI support from the NVIDIA CONTAINER TOOLKIT (see https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#container-device-interface-cdi-support for further podman CDI instructions). In `ros-noetic-docker/noetic/ltov-slam-podman/compose.yaml`, make sure you have correct paths in "volumes".

Pull docker image to podman (select `docker.io:tiejean/tiejean/noetic-ltov-slam:evaluation` if you're prompted):
```
podman pull tiejean/tiejean/noetic-ltov-slam:evaluation
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

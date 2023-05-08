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
* amrl_msgs (heads/master)
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
docker stop $USER-noetic-ltov-slam-app-1
```
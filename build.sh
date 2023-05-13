cd ~/amrl_msgs
make -j

cd ~/ORB_SLAM2
sh build.sh && sh build_ros.sh

cd ~/ORB_SLAM3
sh build.sh && sh build_ros.sh

cd ~/OA-SLAM
sh build.sh
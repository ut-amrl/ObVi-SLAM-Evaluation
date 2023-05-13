cd ~/LTOV-SLAM-Evaluation/amrl_msgs
make -j

cd ~/LTOV-SLAM-Evaluation/ORB_SLAM2
sh build.sh && sh build_ros.sh

cd ~/LTOV-SLAM-Evaluation/ORB_SLAM3
sh build.sh && sh build_ros.sh

cd ~/LTOV-SLAM-Evaluation/OA-SLAM
sh build.sh

cd ~/LTOV-SLAM-Evaluation/ut_vslam
make -j4
# Copy Original Files
mkdir ./nav2_collision_monitor || echo "path exists"
cp -r /opt/ros/humble/share/nav2_collision_monitor/launch ./nav2_collision_monitor/launch
cp -r /opt/ros/humble/share/nav2_collision_monitor/params ./nav2_collision_monitor/params

mkdir ./nav2_bringup || echo "path exists"
cp -r /opt/ros/humble/share/nav2_bringup/launch ./nav2_bringup/launch
cp -r /opt/ros/humble/share/nav2_bringup/params ./nav2_bringup/params

mkdir -p ./slam_toolbox/launch || echo "path exists"
cp -r /opt/ros/humble/share/slam_toolbox/launch/localization_launch.py ./slam_toolbox/launch/localization_launch.py
mkdir ./pointcloud_to_laserscan
cp -r /opt/ros/humble/share/pointcloud_to_laserscan/launch ./pointcloud_to_laserscan/launch

mkdir ./rslidar_sdk || echo "path exists"
cp -r /home/orin/lidar_ws/src/rslidar_sdk-v.1.5.13/config/config.yaml ./rslidar_sdk/config.yaml
mkdir ./scout_description
cp -r /home/orin/scout_ws/src/scout_ros2-humble/scout_description/urdf ./scout_description/urdf


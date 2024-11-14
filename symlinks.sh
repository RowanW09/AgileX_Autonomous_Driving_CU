#!/bin/bash

# To Run: (from same directory)
# sudo chmod +x symlnks.sh
# ./symlinks.sh

# Symlink info:
# Command Structure: ln -sf <source file (use absolute)> <path-to-symlink>
# Reltive path can be used but it is relative to the resultant symlink

# Project Scripts & Map Filers -> Desktop (For ease of development)
ln -sf ~/GimcrackNavigations/scripts ~/Desktop/scripts
ln -sf ~/GimcrackNavigations/maps ~/Desktop/maps

# IS 1.11.2 SDK ROS 2 Implimentation -> Home 
ln -sf ~/GimcrackNavigations/ls_ws ~/ls_ws
ln -sf ~/GimcrackNavigations/inertial-sense-sdk ~/intertial-sense-sdk

# Ros2 & Nav2 Custom Files -> Default Locations
ln -sf ~/GimcrackNavigations/modfied/nav2_collision_monitor/launch /opt/ros/humble/share/nav2_collision_monitor/launch 
ln -sf ~/GimcrackNavigations/modfied/nav2_collision_monitor/params /opt/ros/humble/share/nav2_collision_monitor/params 

ln -sf ~/GimcrackNavigations/modfied/nav2_bringup/launch /opt/ros/humble/share/nav2_bringup/launch
ln -sf ~/GimcrackNavigations/modfied/nav2_bringup/params /opt/ros/humble/share/nav2_bringup/params 

ln -sf ~/GimcrackNavigations/modfied/slam_toolbox/launch/localization_launch.py /opt/ros/humble/share/slam_toolbox/launch/localization_launch.py 
ln -sf ~/GimcrackNavigations/modfied/pointcloud_to_laserscan/launch /opt/ros/humble/share/pointcloud_to_laserscan/launch 

ln -sf ~/GimcrackNavigations/modfied/rslidar_sdk/config.yaml ~/lidar_ws/src/rslidar_sdk-v.1.5.13/config/config.yaml 
ln -sf ~/GimcrackNavigations/modfied/scout_description/urdf ~/scout_ws/src/scout_ros2-humble/scout_description/urdf 
'


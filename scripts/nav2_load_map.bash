#!/bin/bash

# Nav2 Setup Script
gnome-terminal --tab -- bash -c 'sudo ip link set up can0 type can bitrate 500000; exec bash'
sleep 2
gnome-terminal --tab -- bash -c 'ros2 launch scout_base scout_base.launch.py; exec bash'
sleep 2
gnome-terminal --tab -- bash -c 'ros2 launch scout_description scout_base_description.launch.py; exec bash'
sleep 2
gnome-terminal --tab -- bash -c 'ros2 launch rslidar_sdk start.py; exec bash'
sleep 2
gnome-terminal --tab -- bash -c 'ros2 launch pointcloud_to_laserscan sample_pointcloud_to_laserscan_launch.py; exec bash'
sleep 2
gnome-terminal --tab -- bash -c 'ros2 launch nav2_bringup bringup_launch.py use_sim_time:=False autostart:=False map:=/home/orin/Desktop/maps/CAMP_v4.yaml; exec bash' #map:=/home/orin/Desktop/ERC1.yaml'
sleep 3
gnome-terminal --tab -- bash -c 'ros2 launch nav2_collision_monitor collision_monitor_node.launch.py; exec bash'
sleep 2
gnome-terminal --tab -- bash -c 'ros2 run rviz2 rviz2 -d $(ros2 pkg prefix nav2_bringup)/share/nav2_bringup/rviz/nav2_default_view.rviz; exec bash'

#!/bin/bash

# Nav2 Bringup With Preloaded Map
gnome-terminal --tab -- bash -c 'ros2 launch scout_base scout_base.launch.py; exec bash'
sleep 2
gnome-terminal --tab -- bash -c 'ros2 launch scout_description scout_base_description.launch.py; exec bash'
sleep 2
gnome-terminal --tab -- bash -c 'ros2 launch rslidar_sdk start.py; exec bash'
sleep 2
gnome-terminal --tab -- bash -c 'ros2 launch pointcloud_to_laserscan sample_pointcloud_to_laserscan_launch.py; exec bash'
sleep 2
gnome-terminal --tab -- bash -c 'ros2 launch nav2_bringup bringup_launch.py use_sim_time:=False autostart:=False map:=<pathToMapFile>; exec bash'
sleep 3
gnome-terminal --tab -- bash -c 'ros2 launch nav2_collison_monitor collision_monitor_node.launch.py; exec bash'
sleep 2
gnome-terminal --tab -- bash -c 'ros2 run rviz2 rviz2 -d $(ros2 pkg prefix nav2_bringup)/share/nav2_bringup/rviz/nav2_default_view.rviz; exec bash'

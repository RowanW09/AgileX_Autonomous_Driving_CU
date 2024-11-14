#!/bin/bash

# everything but Nav2 Setup Script
gnome-terminal --tab -- bash -c 'ros2 launch scout_base scout_base.launch.py; exec bash'
sleep 2
gnome-terminal --tab -- bash -c 'ros2 launch scout_description scout_base_description.launch.py; exec bash'
sleep 2
gnome-terminal --tab -- bash -c 'ros2 launch rslidar_sdk start.py; exec bash'
sleep 2
gnome-terminal --tab -- bash -c 'ros2 launch pointcloud_to_laserscan sample_pointcloud_to_laserscan_launch.py; exec bash'

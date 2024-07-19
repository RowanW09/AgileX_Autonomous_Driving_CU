# AgileX_Autonomous_Driving_CU
Using AgileX Robotics' Scout 2.0 and RoboSense LiDAR for autonomous driving

## Research Objective
- Understand how to pair AgileX robtics with ROS to create an Unmanned Ground Vehicle
- Explore methods such as Autoware and Cartography
- Use LiDAR and other sensors to map and navigate indoors and outdoors

## Hardware
### Scout 2.0:
- AgileX Scout 2.0
- Auto Kit
- Nvidia Jetson AGX Orin
- Robosense LiDAR Helios 16

## Software
- Ubuntu 22.04
- ROS2 Humble
- Nav2
- Slam toolbox

## ROS2
Install Guide: https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html

Create a ROS2 Workspace
```
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws
colcon build --symlink-install
source ~/ros2_ws/install/setup.bash
```

### Point CLoud To Laser Scan
Install: 
```
sudo apt-get install ros-humble-pointcloud-to-laserscan
```

pointcloud-to-laserscan.py Configuration:
```
from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node


def generate_launch_description():
    return LaunchDescription([
        Node(
            package='pointcloud_to_laserscan', executable='pointcloud_to_laserscan_node',
            remappings=[('cloud_in', '/rslidar_points'),
                        ('scan', '/scan')],
            parameters=[{
                'target_frame': '',
                'transform_tolerance': 0.01,
                'min_height': -0.4,
                'max_height': 1.0,
                'angle_min': -3.1415,  # -M_PI/2
                'angle_max': 3.1415,  # M_PI/2
                'angle_increment': 0.0087,  # M_PI/360.0
                'scan_time': 0.3333,
                'range_min': 0.45,
                'range_max': 30.0,
                'use_inf': True,
                'inf_epsilon': 1.0
            }],
            name='pointcloud_to_laserscan'
        )
    ])
```
Launch:
```
ros2 launch pointcloud_to_laserscan sample_pointcloud_to_laserscan_launch.py
```

### slam_toolbox

## Scout 2.0
### Scout SDK
Install: https://github.com/agilexrobotics/scout_ros2

Launch:
```
ros2 launch scout_base scout_base.launch.py
```
### Scout Description

Install:
```

```
Launch:
```
ros2 launch scout_description scout_base_description.launch.py
```

Scout_Description is one of the packages contained in the scout_ros2 github provided by AgileX. This package is created to provide a URDF model of the scout robot. This package provides the dimensions and visual appearance of the scout robot, as well as the transform information of the robot. However as currently stated in the github commit history for scout_ros2, the provided code is not fully functional.

In the scout_description package, XACRO files are provided to generate the URDF model. The URDF files should not be manually edited as any changes will be overwritten when the URDF file is regenerated from the XACRO file. These files can be found in the “pathto_ws//src/scout_ros2-humble/scout_description/urdf” directory from the workspace used to install scout_ros2.

To fix the errors for the scout 2.0 description, several modifications of multiple XACRO files will be needed. Most of these edits involve correcting the paths to mesh files and wheel XACRO files. Key changes to the XACRO files are highlighted in bold below.

An additional link will also need to be added for the LiDAR sensor. This describes where the LiDAR sensor is relative to the center of the robot (the base_link). Collision and visual information can also be added to the LiDAR sensor. The modifications needed to add the LiDAR transform can be found in bold at the end of the scout_v2.xacro file.

Once the XACRO files are modified. The URDF file must be updated. Assuming you modified the XACRO files in the src directory, rerunning the “colcon build” command will update the URDF files. The scout_description package can then be launched to verify if the URDF model was successfully generated.

## Robosense LiDAR
### LiDAR SDK
Install: https://github.com/RoboSense-LiDAR/rslidar_sdk
### LiDAR Scanning

## Nav2

















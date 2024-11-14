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
To generate a 2D map with slam-toolbox, it is necessary to convert the 3D point cloud data from the LiDAR sensor into a 2D laser scan. This can be done using the pointcloud_to_laserscan package, and can be installed using the following command.
Install: 
```
sudo apt-get install ros-humble-pointcloud-to-laserscan
```
To achieve the desired functionality, you must modify the provided sample python launch files or create a custom one. The launch file used to convert the point cloud data from the rslidar_sdk can be found below. If you are using a different LiDAR sensor, then the remapping for the input point cloud must be modified. If you are using nav2, the output should be left as /scan, since that is what nav2 and slam-toolkit are expecting. Here the parameters of the conversion can be modified and the details of these parameters can be found on the github page. If the pointcloud_to_laserscan package was installed using apt-get, then the launch files can be found in the following directory: “/opt/ros/humble/share/pointcloud_to_laserscan/launch” (root privileges are needed to modify these files).

Once the launch files are properly configured, it can be launched using the following command (the name of the .py file will vary based on the name of your desired launch .py file). The package is programmed to only output the conversion if there is a subscriber for the output topic. Any errors output to the terminal can be used for debugging.

Launch:
```
ros2 launch pointcloud_to_laserscan sample_pointcloud_to_laserscan_launch.py
```

### slam_toolbox
https://github.com/SteveMacenski/slam_toolbox

https://docs.nav2.org/tutorials/docs/navigation2_with_slam.html

https://roscon.ros.org/2019/talks/roscon2019_slamtoolbox.pdf


## Scout 2.0
### Scout SDK
Install: https://github.com/agilexrobotics/scout_ros2

Launch:
```
ros2 launch scout_base scout_base.launch.py
```
### Scout Description

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
Nav2 is a navigation stack for ROS2 allowing robots to autonomously navigate environments and perform various tasks. Nav2 can be installed using the commands shown below. In the nav2 documentation there are references to using gazebo and turtlebot for simulation. However as of writing this documentation, the packages for simulation were not found or easily installable. Any mention of simulation in the documentation for Nav2 can safely be ignored.
```
sudo apt install ros-humble-navigation2 
sudo apt install ros-humble-nav2-bringup
```
### Robot Setup

The Nav2 documentation features a helpful set of pages regarding setting up your own robot from scratch. Since we are using scout 2.0 from AgileX, the information we need has already been provided via the scout_base and scout_description packages (assuming you fixed the broken scout_description package and added your specific sensor setup). The provided information is helpful, even if you are not necessarily setting things up from scratch yourself.

Nav2 documentation “First-Time Robot Setup Guide”
https://docs.nav2.org/setup_guides/index.html

### SLAM / Navigation

The documentation for Nav2 recommends using slam-toolbox for navigation while mapping. It is possible to use another slam package so long as it outputs the data topics that Nav2 is expecting. Assuming that slam-toolbox has already been installed, only 2 commands are necessary to begin autonomous navigation:

terminal 1:
 ```
ros2 launch nav2_bringup navigation_launch.py
```
terminal 2:
```
ros2 launch slam_toolbox online_async_launch.py
```

The full chain of events needed to reach this point are as follows:
    Launch your robot’s interface and state publisher (scout_base and scout_description in our case)
    Launch your LiDAR’s point cloud data publisher (rslidar_sdk in our case)
    Launch pointcloud-to-laserscan to convert 3D data to 2D for slam-toolkit
    Launch Nav2 bring up
    Launch slam-toolbox

### Collision Monitor
By default there is no collision detection enabled in nav2. It will route around obstacles but if the robot is left with no other choice it will collide with walls, objects, etc.. nav2_collision_monitor can be used to prevent collisions through custom polygons. The collision monitor works by modifying the velocity commands that are eventually given to the robot.

If an object is detected inside the polygon (if enough points from the laserscan are within the polygon), then the specified modifier for that polygon will be performed. It is common to have a “stop” polygon and a “slow down” polygon. If an object is getting too close for comfort to the scout, then the speed will be reduced. If the scout is about to collide with an object, then it will stop completely. The scout will continue to move again if the object that entered the “stop” polygon is removed. If the object that triggered the “stop” polygon is a static object (ie. a wall), then the robot will be permanently stuck without manual intervention. Polygon specifications can be configured through the “collision_monitor_params.yaml” file that can be found in the “/opt/ros/humble/share/nav2_collision_monitor/params” directory (assuming nav2 was installed using apt / apt-get)

As noted in the nav2 tutorial linked above, it is important to ensure that the velocity commands are routed through the collision monitor. These can be done by modifying the remappings in the bringup launch file that is being used. Once the velocity commands have the proper topic remapping, simply launch the nav2_collision_monitor node.

Launch:
```
ros2 launch nav2_collision_monitor collision_monitor_node.launch.py
```
















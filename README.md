# AgileX_Autonomous_Driving_CU
Using AgileX Robotics' Scout 2.0 and RoboSense LiDAR for autonomous driving

### Research Objective
- Understand how to pair AgileX robtics with ROS to create an Unmanned Ground Vehicle
- Explore methods such as Autoware and Cartography
- Use LiDAR and other sensors to map and navigate indoors and outdoors

### Hardware
Scout 2.0:
- AgileX Scout 2.0
- Auto Kit
- Nvidia Jetson AGX Orin
- Robosense LiDAR Helios 16
Scout Mini:
- AgileX Scout Mini
- Intel NUC
- Livox HAP (TX) LiDAR

### Software
- Ubuntu 22.04
- ROS2 Humble
- Nav2
- Slam toolbox

### Manual Drive
only run this once after system startup
```
rosrun scout_bringup bringup_can2usb.bash
```
```
roslaunch scout_bringup scout_robot_base.launch
```
Open a new terminal (Remember to reduce the speed!)
```
roslaunch scout_bringup scout_teleop_keyboard.launch
```
###### Install Dependencies
```
$ rosdep update
$ rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO
```
###### Compile Workspace
```
$ colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release
```

#### Setting Up RoboSense LiDAR
```
https://github.com/RoboSense-LiDAR/rs_driver.git
```

#### Make catkin Workspace
```
$ mkdir ros2_ws
$ cd ~/catkin_ws
$ catkin_make
$ source devel/setup.bash
```








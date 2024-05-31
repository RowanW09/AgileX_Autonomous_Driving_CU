# AgileX_Autonomous_Driving_CU
Using AgileX Robotics' Scout 2.0 and RoboSense LiDAR for autonomous driving

### Research Objective
- Understand how to pair AgileX robtics with ROS to create an Unmanned Ground Vehicle
- Explore methods such as Autoware and Cartography
- Use LiDAR and other sensors to map and navigate indoors and outdoors

### Hardware
- AgileX Scout 2.0
- Auto Kit
- Nvidia Jetson Xavier NX
- Robosense LiDAR

### Software
- Ubuntu 18.04
- ROS Melodic
- Autoware

#### Setting Up Autoware
##### System Dependencies for ubuntu 18.04 and ROS Melodic
```
$ sudo apt update
$ sudo apt install -y python-catkin-pkg python-rosdep ros-$ROS_DISTRO-catkin
$ sudo apt install -y python3-pip python3-colcon-common-extensions python3-setuptools python3-vcstool
$ pip3 install -U setuptools
```

###### Creake Autoware Workspace
```
$ mkdir -p autoware.ai/src
$ cd autoware.ai
```
###### Download Workspace Configuration
```
$ wget -O autoware.ai.repos "https://raw.githubusercontent.com/autowarefoundation/autoware_ai/1.12.0/autoware.ai.repos"
```
###### Download Autoware to Workspace
```
$ vcs import src < autoware.ai.repos
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
$ mkdir catkin_ws
$ cd ~/catkin_ws
$ catkin_make
$ source devel/setup.bash
```

## Create Launch File
```
$ cd ~/catkin_ws/src/ros_rslidar/roslidar_pointcloud/launch
$ nano fileName.launch
$ chmod +x fileName.launch
```
Check Launch File Dependencies
```
$ roslaunch-deps -w fileName.launch
```

### ROS Launch
```
$ roslaunch pakcage_name fileName.launch
```

## ROS Launch cmd
RoboSense LiDAR
```
roslaunch rslidar_sdk start/launch
```
RealSense Camera
```
roslaunch realsense2_camera rs_camera.launch
```

## Install RealSenseCamera
```
sudo apt-get install ros-$ROS_DISTRO-realsense2-camera
```
## Install Repository
```
git clone https://github.com/IntelRealSense/realsense-ros.git
```
## Installing Packages
Register the servers public key
```
sudo mkdir -p /etc/apt/keyrings
curl -sSf https://librealsense.intel.com/Debian/librealsense.pgp | sudo tee /etc/apt/keyrings/librealsense.pgp > /dev/null
```
## Make sure apt HTTPS support is installed
```
sudo apt-get install apt-transport-https
```
## Add the server to the list of repositories
```
echo "deb [signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo `lsb_release -cs` main" | \
sudo tee /etc/apt/sources.list.d/librealsense.list
sudo apt-get update
```
## Install the libraries
```
sudo apt-get install librealsense2-dkms
sudo apt-get install librealsense2-utils
```
The above two lines will deploy librealsense2 udev rules, build and activate kernel modules, runtime library and executable demos and tools.

## Optionally install the developer and debug packages
```
sudo apt-get install librealsense2-dev
sudo apt-get install librealsense2-dbg
```
With dev package installed, you can compile an application with librealsense using g++ -std=c++11 filename.cpp -lrealsense2 or an IDE of your choice.
## Reconnect the Intel RealSense depth camera and run:
```
realsense-viewer
```
to verify the installation.

## Verify that the kernel is updated
```
modinfo uvcvideo | grep "version:"
```
should include realsense string

### Clone latest RealSense ROS
```
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
```






























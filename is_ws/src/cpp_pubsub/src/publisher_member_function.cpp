// Copyright 2016 Open Source Robotics Foundation, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <stdio.h>

#include <chrono>
#include <functional>
#include <memory>
#include <string>

#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/string.hpp"

#include "sensor_msgs/msg/imu.hpp"
#include "sensor_msgs/msg/nav_sat_fix.hpp"
#include "sensor_msgs/msg/nav_sat_status.hpp"

#include "/home/orin/inertial-sense-sdk/src/InertialSense.h"
#include "InertialSense.h"

using namespace std::chrono_literals;

static void msgHandlerIsb(InertialSense* i, p_data_t* data, int pHandle)
{
	static uint64_t dataCount;
	printf("Data count: %" PRIu64 "          \r", ++dataCount);
}

/* This example creates a subclass of Node and uses std::bind() to register a
 * member function as a callback from the timer. */

class MinimalPublisher : public rclcpp::Node
{
public:
  MinimalPublisher()
  : Node("minimal_publisher"), count_(0)
  {
    nsf_publisher_ = this->create_publisher<sensor_msgs::msg::NavSatFix>("is_nav_sat_fix", 10);
    imu_publisher_ = this->create_publisher<sensor_msgs::msg::Imu>("is_imu", 10);
    timer_ = this->create_wall_timer(
      500ms, std::bind(&MinimalPublisher::timer_callback, this));
  }

private:
  void timer_callback()
  {
    auto nsf_message = sensor_msgs::msg::NavSatFix();
    auto imu_message = sensor_msgs::msg::Imu();
    nsf_publisher_->publish(nsf_message);
    imu_publisher_->publish(imu_message);
    RCLCPP_INFO(this->get_logger(), "Hello world");
  }
  
  rclcpp::TimerBase::SharedPtr timer_;
  rclcpp::Publisher<sensor_msgs::msg::NavSatFix>::SharedPtr nsf_publisher_;
  rclcpp::Publisher<sensor_msgs::msg::Imu>::SharedPtr imu_publisher_;
  size_t count_;
};

int main(int argc, char * argv[])
{
	//rclcpp::Node;
	rclcpp::init(argc, argv);
	
	auto mynode = std::make_shared<rclcpp::Node>("hello_world_node");
		
	InertialSense inertialSense(msgHandlerIsb);
	//InertialSense inertialSense();
	if (!inertialSense.Open("/dev/ttyACM0")) {
		//RCLCPP_INFO(this->get_logger(), "Failed to open port\n");
		  RCLCPP_INFO(mynode->get_logger(), "Fail\n");
	} else {
		//RCLCPP_INFO(this->get_logger(), "Port openned successfully\n");
		RCLCPP_INFO(mynode->get_logger(), "success\n");
	}
	inertialSense.Close();
	
  rclcpp::spin(std::make_shared<MinimalPublisher>());
  rclcpp::shutdown();
  return 0;
}

cmake_minimum_required(VERSION 3.8)
project(cpp_pubsub)

SET(IS_SDK_DIR "/home/orin/inertial-sense-sdk" )

add_definitions(-w)
SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=gnu17 -fms-extensions -Wl,--no-as-needed -DPLATFORM_IS_LINUX -ludev" )
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++17 -fms-extensions -Wl,--no-as-needed -DPLATFORM_IS_LINUX -ludev")

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic -pthread)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
# uncomment the following section in order to fill in
# further dependencies manually.
# find_package(<dependency> REQUIRED)

find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)

# added for is-sdk ---------------------------------------------------------------------------

# yamlcpp needs to know it's a static lib
add_definitions(-DYAML_CPP_STATIC_DEFINE)

file(GLOB SOURCES_SDK
	"${IS_SDK_DIR}/src/*.c"
	"${IS_SDK_DIR}/src/*.cpp"
	"${IS_SDK_DIR}/src/*.h"
	"${IS_SDK_DIR}/hw-libs/bootloader/bootloaderShared.c"
	"${IS_SDK_DIR}/src/yaml-cpp/*.cpp"
	"${IS_SDK_DIR}/src/yaml-cpp/*.h"
	"${IS_SDK_DIR}/src/yaml-cpp/contrib/*.cpp"
	"${IS_SDK_DIR}/src/yaml-cpp/contrib/*.h"
	"${IS_SDK_DIR}/src/yaml-cpp/node/*.cpp"
	"${IS_SDK_DIR}/src/yaml-cpp/node/*.h"
)

file(GLOB SOURCES_LIB_USB
	"${IS_SDK_DIR}/src/libusb/libusb/*.h"
	"${IS_SDK_DIR}/src/libusb/libusb/*.c"
	"${IS_SDK_DIR}/src/libusb/libusb/os/*linux*"
	"${IS_SDK_DIR}/src/libusb/libusb/linux/*.h"
	"${IS_SDK_DIR}/src/libusb/libusb/os/*posix*"
)

#list(APPEND SOURCES_SDK SOURCES_LIB_USB)

#message("Building static lib for ${PROJECT_NAME}")
	
# Add sdk sources to this project
# add_library(${PROJECT_NAME} ${SOURCES_SDK} ${SOURCES_PROJECT})
	
# Linux specific lib compiler option
# target_compile_options(${PROJECT_NAME} PUBLIC -fPIC)
	
# Alias for the static lib
#add_library(${PROJECT_NAME}::libinertialsense ALIAS ${PROJECT_NAME})

# Include paths

include_directories(${PROJECT_NAME} PUBLIC
	${IS_SDK_DIR}/src
	${IS_SDK_DIR}/src/InertialSense.h
	${IS_SDK_DIR}/src/libusb
	${IS_SDK_DIR}/src/libusb/libusb
	${IS_SDK_DIR}/src/libusb/libusb/linux
	${IS_SDK_DIR}/src/yaml-cpp
	${IS_SDK_DIR}/external
	${IS_SDK_DIR}/external
)


#---------------------------------------------------------------------------

# message("${SOURCES_SDK}")

#target_link_libraries( pthread)
add_executable(talker src/publisher_member_function.cpp ${SOURCES_SDK} ${SOURCES_LIB_USB})
#add_executable(talker src/publisher_member_function.cpp "${IS_SDK_DIR}/src/libusb/libusb/libusb.h")
message("links")
#target_link_libraries(talker ${CMAKE_CURRENT_LIST_DIR}/src/libISLoggerExample.a InertialSense pthread)

ament_target_dependencies(talker rclcpp std_msgs sensor_msgs)

message("install")
install(TARGETS
  talker
  DESTINATION lib/${PROJECT_NAME})

message("build testing")
if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  # the following line skips the linter which checks for copyrights
  # comment the line when a copyright and license is added to all source files
  set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # comment the line when this package is in a git repo and when
  # a copyright and license is added to all source files
  set(ament_cmake_cpplint_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package()

cmake_minimum_required(VERSION 3.0.2)
project(keisuu_box_msgs)

## Find catkin macros and libraries
find_package(catkin REQUIRED COMPONENTS
  std_msgs
  genmsg
)

# Generate messages in the 'msg' folder
add_message_files(
  FILES
  Motor.msg
  MotorCmdCurrent.msg
  MotorCmdPosition.msg
  MotorCmdVelocity.msg
  MotorPosition.msg
)

## Generate added messages and services with any dependencies listed here
generate_messages(
  DEPENDENCIES
  std_msgs
)

catkin_package()
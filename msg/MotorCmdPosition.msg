# the node to control motors can be used with this declarative message
Header header
uint8 usb_id
uint32 motor_id   # motor id
uint16 max_speed  # max speed [dps]
float32 angle      # target angle [deg]

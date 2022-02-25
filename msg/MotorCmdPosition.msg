# the node to control motors can be used with this declarative message
Header header
uint8 usb_id
uint32 motor_id   # motor id
# bool direction    # true for clockwise and false for counterclockwise
uint16 max_speed  # max speed [dps]
uint16 angle      # target angle [deg]

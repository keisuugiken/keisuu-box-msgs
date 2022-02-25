# the node to control motors can be used with this declarative message
Header header
uint8 usb_id
uint32 motor_id   # motor id
uint16 iq         # torque current. the value range: -2000~2000, corresponding to the actual torque current range -32A~32A

#====================================
# Clock
#====================================
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports clk_pin]

#====================================
# LEDs
#====================================
set_property -dict {PACKAGE_PIN F6 IOSTANDARD LVCMOS33} [get_ports {leds_pin[0]}]
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33} [get_ports {leds_pin[1]}]
set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33} [get_ports {leds_pin[2]}]
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports {leds_pin[3]}]
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports {leds_pin[4]}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {leds_pin[5]}]
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {leds_pin[6]}]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {leds_pin[7]}]
set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports {leds_pin[8]}]
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS33} [get_ports {leds_pin[9]}]
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports {leds_pin[10]}]
set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports {leds_pin[11]}]
set_property -dict {PACKAGE_PIN K6 IOSTANDARD LVCMOS33} [get_ports {leds_pin[12]}]
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {leds_pin[13]}]
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports {leds_pin[14]}]
set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS33} [get_ports {leds_pin[15]}]

#====================================
# Buttons
#====================================
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports rst_pin]

#====================================
# Switches
#====================================
set_property -dict {PACKAGE_PIN P5 IOSTANDARD LVCMOS33} [get_ports {sw_pin[0]}]
set_property -dict {PACKAGE_PIN P4 IOSTANDARD LVCMOS33} [get_ports {sw_pin[1]}]
set_property -dict {PACKAGE_PIN P3 IOSTANDARD LVCMOS33} [get_ports {sw_pin[2]}]
set_property -dict {PACKAGE_PIN P2 IOSTANDARD LVCMOS33} [get_ports {sw_pin[3]}]
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {sw_pin[4]}]
set_property -dict {PACKAGE_PIN M4 IOSTANDARD LVCMOS33} [get_ports {sw_pin[5]}]
set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS33} [get_ports {sw_pin[6]}]
set_property -dict {PACKAGE_PIN R1 IOSTANDARD LVCMOS33} [get_ports {sw_pin[7]}]

#====================================
# Bluetooth
#====================================
set_property -dict {PACKAGE_PIN N2 IOSTANDARD LVCMOS33} [get_ports {rxd_pin}]
set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS33} [get_ports {txd_pin}]

set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports bt_pw_on]
set_property -dict {PACKAGE_PIN C16 IOSTANDARD LVCMOS33} [get_ports bt_master_slave]
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports bt_sw_hw]
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33} [get_ports bt_rst_n]
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports bt_sw]
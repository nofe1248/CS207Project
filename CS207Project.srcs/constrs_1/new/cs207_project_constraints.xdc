#====================================
# Clock
#====================================
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports clk]

#====================================
# LEDs
#====================================
set_property -dict {PACKAGE_PIN F6 IOSTANDARD LVCMOS33} [get_ports {leds[0]}]
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33} [get_ports {leds[1]}]
set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33} [get_ports {leds[2]}]
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports {leds[3]}]
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports {leds[4]}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {leds[5]}]
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {leds[6]}]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {leds[7]}]
set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports {leds[8]}]
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS33} [get_ports {leds[9]}]
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports {leds[10]}]
set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports {leds[11]}]
set_property -dict {PACKAGE_PIN K6 IOSTANDARD LVCMOS33} [get_ports {leds[12]}]
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {leds[13]}]
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports {leds[14]}]
set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS33} [get_ports {leds[15]}]

#====================================
# Buttons
#====================================

#====================================
# Switches
#====================================

#====================================
# Bluetooth
#====================================
set_property -dict {PACKAGE_PIN N2 IOSTANDARD LVCMOS33} [get_ports {bt_rx}]
set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS33} [get_ports {bt_tx}]

set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports bt_pw_on]
set_property -dict {PACKAGE_PIN C16 IOSTANDARD LVCMOS33} [get_ports bt_master_slave]
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports bt_sw_hw]
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33} [get_ports bt_rst_n]
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports bt_sw]
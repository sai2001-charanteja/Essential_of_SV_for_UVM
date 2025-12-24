vlib work
vdel -all
vlib work

vlog -sv packet_pkg.sv port_if.sv switch_port.sv switch_test.sv vc_test.sv 

vsim work.top
#vsim work.packet_test

run -all
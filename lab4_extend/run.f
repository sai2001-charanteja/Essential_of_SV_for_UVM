vlib work
vdel -all
vlib work

vlog -sv packet_pkg.sv packet_test.sv 

vsim work.packet_test

run -all
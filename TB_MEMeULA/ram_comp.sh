#!/bin/bash


ghdl -a as_ram.vhdl
wait
ghdl -a tb_as_ram.vhdl
wait

ghdl -e tb_as_ram

wait

ghdl -r tb_as_ram --stop-time=5170ns --wave=tb_as_ram.ghw



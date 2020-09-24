v {xschem version=2.9.7 file_version=1.1}
G {}
V {}
S {}
E {}
N 420 -160 420 -120 {lab=GND}
N 420 -240 420 -220 {lab=OUT1}
N 420 -320 420 -300 {lab=VDD}
N 360 -190 380 -190 {lab=OUT1}
N 360 -230 360 -190 {lab=OUT1}
N 360 -230 420 -230 {lab=OUT1}
N 420 -230 480 -230 {lab=OUT1}
N 580 -320 580 -300 {lab=VDD}
N 580 -240 580 -220 {lab=OUT2}
N 580 -160 580 -120 {lab=GND}
N 520 -230 580 -230 {lab=OUT2}
N 520 -230 520 -190 {lab=OUT2}
N 520 -190 540 -190 {lab=OUT2}
N 580 -230 640 -230 {lab=OUT2}
C {nmos4.sym} 400 -190 0 0 {name=X1 model=sky130_fd_pr__nfet_01v8 w=7 l=1 m=1}
C {res.sym} 420 -270 0 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {gnd.sym} 580 -120 0 0 {name=l1 lab=GND}
C {lab_wire.sym} 480 -230 0 0 {name=l2 sig_type=std_logic lab=OUT1}
C {netlist.sym} 420 -480 0 0 {name=s1
only_toplevel=true
value=".lib sky130_fd_pr/models/sky130.lib.spice tt
.op
.dc Vsupply 0 5 0.1"}
C {vdd.sym} 420 -320 0 0 {name=l3 lab=VDD}
C {lab_pin.sym} 420 -190 0 1 {name=l4 sig_type=std_logic lab=GND}
C {code_shown.sym} 420 -540 0 0 {name=STIMULI
only_toplevel=true
value="Vsupply VDD GND DC 1.8
.param temp=27"}
C {nmos4.sym} 560 -190 0 0 {name=X2 model=sky130_fd_pr__nfet_g5v0d10v5 w=20 l=1 m=4}
C {vdd.sym} 580 -320 0 0 {name=l5 lab=VDD}
C {res.sym} 580 -270 0 0 {name=R2
value=1k
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 580 -190 0 1 {name=l6 sig_type=std_logic lab=GND}
C {gnd.sym} 420 -120 0 0 {name=l7 lab=GND}
C {lab_wire.sym} 640 -230 0 0 {name=l8 sig_type=std_logic lab=OUT2}

v {xschem version=2.9.7 file_version=1.1}
G {}
V {}
S {}
E {}
N 420 -160 420 -120 {lab=GND}
N 420 -240 420 -220 {lab=OUT}
N 420 -320 420 -300 {lab=VDD}
N 360 -190 380 -190 {lab=OUT}
N 360 -230 360 -190 {lab=OUT}
N 360 -230 420 -230 {lab=OUT}
N 420 -230 480 -230 {lab=OUT}
C {nmos4.sym} 400 -190 0 0 {name=X1 model=sky130_fd_pr__nfet_01v8 w=5u l=1u m=1}
C {res.sym} 420 -270 0 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {gnd.sym} 420 -120 0 0 {name=l1 lab=GND}
C {lab_wire.sym} 480 -230 0 0 {name=l2 sig_type=std_logic lab=OUT}
C {netlist.sym} 420 -440 0 0 {name=s1
only_toplevel=true
value=".lib sky130_fd_pr/models/sky130.lib.spice tt
.op
.save all"}
C {vdd.sym} 420 -320 0 0 {name=l3 lab=VDD}
C {lab_pin.sym} 420 -190 0 1 {name=l4 sig_type=std_logic lab=GND}
C {code_shown.sym} 420 -510 0 0 {name=STIMULI
only_toplevel=true
value="VSUPPLY VDD 0 DC 1.8V
.PARAM TEMP=27"}

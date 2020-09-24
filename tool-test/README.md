# Tool test

Simple design to verify the PDK and tools are working as expected.

Using XSCHEM with NGSPICE

XSCHEM produces the following netlist for this design:

```
**.subckt tooltest
X1 OUT1 OUT1 GND GND sky130_fd_pr__nfet_01v8 w=7 l=1 m=1
R1 VDD OUT1 1k m=1
X2 OUT2 OUT2 GND GND sky130_fd_pr__nfet_g5v0d10v5 w=20 l=1 m=4
R2 VDD OUT2 1k m=1
**** begin user architecture code

.lib sky130_fd_pr/models/sky130.lib.spice tt
.op
.dc Vsupply 0 5 0.1


Vsupply VDD GND DC 1.8
.param temp=27

**** end user architecture code
**.ends
.GLOBAL GND
.GLOBAL VDD
.end
```

The netlist is written to the default `~/.xschem/simulations` directory.
In this directory I have created a symlink `sky130_fd_pr` that links to
the Skywater 130nm primitives library.

**IMPORTANT: The library uses `.option scale=1u`, so all dimensions
specified are interpreted as if they are in um!  So for a transistor
of width 7 um and length 1 um, you need to write `w=7 l=1`, NOT
`w=7u l=1u`.**

I'm not sure how running NGSPICE in interactive mode is supposed to
work from XSCHEM.  It does not bring up a terminal to interact with the
simulation.  When selecting NGSPICE batch mode, a .raw file is produced,
which can be opened in [gaw](https://gaw.tuxfamily.org/linux/gaw.php).


# Tool test

Simple design to verify the PDK and tools are working as expected.

**Currently, they are not!** :)

Attempting to use XSCHEM with NGSPICE

XSCHEM produces a netlist that looks alright to me:

```
**.subckt tooltest
X1 OUT OUT GND GND sky130_fd_pr__nfet_01v8 w=5u l=1u m=1
R1 VDD OUT 1k m=1
**** begin user architecture code

.lib sky130_fd_pr/models/sky130.lib.spice tt
.op
.save all


Vsupply VDD GND dc 1.8V
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

Running the simulation results in the following error:

```
******
** ngspice-32 : Circuit level simulation program
** The U. C. Berkeley CAD Group
** Copyright 1985-1994, Regents of the University of California.
** Copyright 2001-2020, The ngspice team.
** Please get your ngspice manual from http://ngspice.sourceforge.net/docs.html
** Please file your bug-reports at http://ngspice.sourceforge.net/bugrep.html
** Creation Date: Tue Sep 22 16:56:28 UTC 2020
******

Circuit: **.subckt tooltest

Scale set
Error on line 0 :
  m.x1.msky130_fd_pr__nfet_01v8 out out 0 0 x1:sky130_fd_pr__nfet_01v8__model l=    9.99999999999999955e-07   w=    4.99999999999999956e-06   ad=    0.00000000000000000e+00   as=    0.00000000000000000e+00   pd=    0.00000000000000000e+00   ps=    0.00000000000000000e+00   nrd=    0.00000000000000000e+00   nrs=    0.00000000000000000e+00   sa=    0.00000000000000000e+00   sb=    0.00000000000000000e+00   sd=    0.00000000000000000e+00   nf=    1.00000000000000000e+00   m=    1.00000000000000000e+00 
could not find a valid modelname
    Simulation interrupted due to error!

```

Reason unknown at the moment, tested with both ngspice-31 and ngspice-32.
Transistor W=5u L=1u is one of the bins listed in sky130_fd_pr__nfet_01v8.bins.csv.

I don't understand how this is supposed to work.  File `sky130_fd_pr__nfet_01v8.pm3.spice`
defines the `sky130_fd_pr__nfet_01v8` subcircuit.  Inside this, a MOSFET `msky130_fd_pr__nfet_01v8`
is created with model `sky130_fd_pr__nfet_01v8__model`.  However, this model doesn't seem to
be defined, ngspice can't find it either, according to the error above.  Instead, there are a gazillion
`sky130_fd_pr__nfet_01v8__model.XX` models defined, maybe one for each bin?  But I don't get 
how the correct one is supposed to be chosen for the instance, it doesn't seem to be parameterized
in any way.

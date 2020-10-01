# Notes on resistor models

Check the
[documentation](https://skywater-pdk.readthedocs.io/en/latest/rules/device-details.html#resistors)
for official info on the resistors.

Resistance as determined by the test benches included with the models
for each model at l=10:

```
 1 sky130_fd_pr__res_generic_nd        291.20
 2 sky130_fd_pr__res_generic_pd       1962.15
 3 sky130_fd_pr__res_high_po_0p35    11617.76
 4 sky130_fd_pr__res_high_po_0p69     5310.80
 5 sky130_fd_pr__res_high_po_1p41     2556.68
 6 sky130_fd_pr__res_high_po_2p85     1266.97
 7 sky130_fd_pr__res_high_po_5p73      633.72
 8 sky130_fd_pr__res_high_po          3550.44
 9 sky130_fd_pr__res_iso_pw          15425.78
10 sky130_fd_pr__res_xhigh_po_0p35   57696.95
11 sky130_fd_pr__res_xhigh_po_0p69   29384.24
12 sky130_fd_pr__res_xhigh_po_1p41   14418.62
13 sky130_fd_pr__res_xhigh_po_2p85    7151.60
14 sky130_fd_pr__res_xhigh_po_5p73    3570.24
15 sky130_fd_pr__res_xhigh_po__base  20305.67
16 sky130_fd_pr__res_xhigh_po        21146.97
```

## Model names

The `generic_nd` is an N+ diffusion resistor and the `generic_pd` a
P+ diffusion resistor.  The `high_po` is a P+ poly resistor
and the `xhigh_po` is a P- poly resistor.  The `iso_pw` uses the
P-well resistance.
I'm not seeing the same complement of devices in the
[repo](https://foss-eda-tools.googlesource.com/skywater-pdk/libs/sky130_fd_pr)
as are listed in the
[docs](https://skywater-pdk.readthedocs.io/en/latest/rules/device-details.html#resistors),
not sure why.  The docs talk about local interconnect and metal resistors
in addition to the ones I see in the repo.

## Temperature effect

A simulation to determine the effect of temperature on resistance is in
[resistor-tc.spice](resistor-tc.spice).

### Diffusion and P+ poly silicon resistors showing large positive temp coefficient

![Resistors 1, 2, 8](r1r2r8.png)

Resistors `generic_nd` and `generic_pd`, along with the
`high_po` without suffix, show a positive temperature coefficient.

- For some reason, the value for `generic_nd` from the test bench listed above seems wrong,
at least when scaled.  I scaled it 4.125 times shorter to get it in the same ballpark as
the other resistors.  Not sure what happened there.  The sheet resistance in the docs
seems to agree with me, the test bench result is too low.
- The body of the `generic_pd` needs to be connected to a high voltage to prevent parasitic
diodes from conducting.
- The model for the diffusion resistors seems to show a +/- 12% change from -40°C to 120°C.

### P+ poly resistors

![Resistors 3, 4, 5, 6, 7, 8](r3r4r5r6r7r8.png)

Of the `high_po` models, only the one without suffix shows any temperature coefficient.
The other variants are specialized models for specific widths, but without proper
temperature behavior, they may be of limited use.  The fact that the generic model does
show a temperature effect seems to suggest the other models are deficient in this respect
and should be expected to have temperature dependence as well.

I'm not sure why these are called "precision resistors" by the documentation, since the
generic model seems to show a +/- 5% change from -40°C to 120°C.  The P- poly seems
significantly better.

### P- poly resistors

![Resistors 15, 16](r15r16.png)

If you check the models, you'll see that all `xhigh_po` models of specific width are based
on the `xhigh_po__base` model, so I only put that one in the graph, together with the
generic `xhigh_po`.  Same situation: the models for specific widths don't show any
temperature coefficient, making them of limited use.  The generic model does show a
temperature dependence.

The low temperature dependence deserves a detail:

![Resistor 16 detail](r16.png)

The temperature dependent change is only 0.026% (260 ppm) from -40°C to 120°C, that's
excellent.  In a smaller temp range from -40°C to 55°C, it's only 50 ppm!
Of course, keep in mind the process variations, the docs don't seem to mention them
for P- poly, but if it's similar to P+ poly, expect +/- 15% or so.  But if stability
over temperature is what you need, these P- poly resistors seem to be the way to go.

### P-well resistor

![Resistor 9](r9.png)

The `iso_pw` model also does not show temperature dependence.

## Thoughts

- Of the models that seem to implement a temperature dependence, the `xhigh_po` type
seems to be the most stable over a temperature sweep.
- The lack of temperature dependence in some of the models may make it more difficult
to use them since their constuction is intended for high precision.
- Is the lack of temperature dependence of some models a compatibility issue?  I'm
using `ngspice`, were the models made for a commercial variant of spice?  I do
get a bunch of "unrecognized parameter" warnings, two of which are `unrecognized 
parameter (tref) - ignored`, but they are for the `generic_nd` and `generic_pd`
models, which do exhibit temperature dependence.


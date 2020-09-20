# sky130-power-blocks
Power management related building blocks for the Skywater 130 nm process shuttle

This is intended as a shared repo for power management related building blocks to be used on the Skywater 130 nm process, sponsored by the Google shuttle service.

## Structure

The structure I envision for this repo is like this: each IP block will inhabit its own directory.  There will also be separate directories that contain the files for a specific tapeout.  So the structure may look like:

```
|
|- bandgap1
|- opamp-5mhz
|- fancy-bandgap
|- ldo-1.8v
|- low-side-driver
|- floating-high-side-driver
|- tapeout-1
```

## Desired blocks

Desirable blocks that I'd like to see implemented at some point:

- OPAMPs, likely several to trade off power consumption, bandwidth, offset, etc.
- Bandgap reference.  Since this is so fundamental, we may want several designs to compare.
- Temperature sensor.  Having one block that provides a stable bandgap reference and a proportional-to-absolute-temperature (PTAT) output is probably the way to go.
- Low dropout linear regulator(s).
- Stable oscillator(s).
- Low side driver for SMPS.
- Floating high side driver for SPMPS.
- PWM engine(s) for various power conversion scenarios.

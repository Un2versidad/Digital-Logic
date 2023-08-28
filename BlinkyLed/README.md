# BlinkyLed

This VHDL module implements a frequency divider circuit that generates a blinking LED pattern using an input 100 MHz clock signal.

## Table of Contents
- [Description](#description)
- [Usage](#usage)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Behavior](#behavior)

## Description

The "frec" module takes a 100 MHz clock signal as input and produces a slower blinking LED pattern as output. It divides the input clock frequency by a factor of approximately 2, toggling the LED every half of the input clock's period.

## Usage

1. Include the `frec.vhd` file in your VHDL project.
2. Instantiate the "frec" module in your design hierarchy, connecting the `clk100mhz` input to your 100 MHz clock source and `led` output to the LED indicator.

## Inputs
`clk100mhz (input)`: A 100 MHz clock signal that serves as the input frequency.

## Outputs
`led (output)`: An LED indicator that blinks at a slower frequency compared to the input clock.

## Behavior
The module's architecture, named "Behavioral," contains a process sensitive to the rising edge of the `clk100mhz` input. Within this process, an `led_count` signal is maintained, ranging from 0 to 268435455, initialized to 0.

On each rising edge of the clock signal, the `led_count` is incremented by 1. Depending on the value of `led_count`, the `led` output is controlled:

If `led_count` is less than 49999999, `led` is set to '0', turning off the LED.
If `led_count` is between 49999999 (inclusive) and 99999999 (exclusive), led is set to '1', illuminating the LED.
When `led_count` exceeds 99999999, `led` is turned off ('0') again, and `led_count` is reset to 0, creating the blinking pattern.

Example instantiation:
```vhdl
frec_inst : frec
    port map (
        clk100mhz => your_clock_signal,
        led => your_led_indicator
    );

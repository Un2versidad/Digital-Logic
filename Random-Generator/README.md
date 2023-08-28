# Random-Generator
The Generator is a VHDL program that generates a pseudo-random sequence of 8-bit numbers using the Linear Feedback Shift Register (LFSR) algorithm. It follows best practices for VHDL design and ensures efficiency in its implementation.

The program takes a clock signal (clk) and a reset signal (reset) as inputs. On each rising edge of the clock, it generates the next random number in the sequence based on the current seed value. The reset signal initializes the seed to zero when asserted.

The LFSR algorithm operates by shifting the seed to the right and calculating the feedback bit using an XOR operation on specific bits of the seed. This process repeats for each clock cycle, resulting in a sequence of pseudo-random numbers.

The Generator optimizes performance by separating the next_seed signal from the seed signal and using parallel assignments where possible. This reduces latency and improves concurrency. The reset signal is checked within the process block, following synchronous design methodology.

The program outputs the generated random number through the random signal.

# Note
Please note that while this program generates a pseudo-random sequence, it is not truly random as it depends on the initial seed and the LFSR algorithm. For true randomness, an external source of entropy would be required.

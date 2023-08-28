# 3-to-8 Decoder with Active-Low Enable

This VHDL code demonstrates the behavior of a 3-to-8 decoder with an active-low enable signal and positive logic. It utilizes behavioral programming using signal selection or conditional signal instructions, as discussed in class.
                                 
              +------+            
        A ----|      |---- C[7]  
      B[2] ---|      |---- C[6]  
      B[1] ---|      |---- C[5]  
      B[0] ---|      |---- C[4]  
              |      |---- C[3]  
              |      |---- C[2]  
              |      |---- C[1]  
              |      |---- C[0]  
              +------+            
              
## Truth Table
| A2 | A1 | A0 | D7 | D6 | D5 | D4 | D3 | D2 | D1 | D0 |
|----|----|----|----|----|----|----|----|----|----|----|
| 0  | 0  | 0  | 1  | 0  | 0  | 0  | 0  | 0  | 0  | 0  |
| 0  | 0  | 1  | 0  | 1  | 0  | 0  | 0  | 0  | 0  | 0  |
| 0  | 1  | 0  | 0  | 0  | 1  | 0  | 0  | 0  | 0  | 0  |
| 0  | 1  | 1  | 0  | 0  | 0  | 1  | 0  | 0  | 0  | 0  |
| 1  | 0  | 0  | 0  | 0  | 0  | 0  | 1  | 0  | 0  | 0  |
| 1  | 0  | 1  | 0  | 0  | 0  | 0  | 0  | 1  | 0  | 0  |
| 1  | 1  | 0  | 0  | 0  | 0  | 0  | 0  | 0  | 1  | 0  |
| 1  | 1  | 1  | 0  | 0  | 0  | 0  | 0  | 0  | 0  | 1  |

## Code Description

The VHDL code consists of an entity `dec3a8` and an architecture `Behavioral`. Here's a breakdown of the code functionality:

### Entity

The entity `dec3a8` defines the following ports:

- `A` (input): Enable signal, active-low
- `B` (input): 3-bit input signal representing the decoder's select lines
- `C` (output): 8-bit output signal representing the decoder's outputs

### Architecture

The architecture `Behavioral` implements the behavior of the 3-to-8 decoder. Here's a summary of its functionality:

1. Declaration of internal signal: `ax` - an 8-bit vector used for intermediate calculations.
2. Using a `with-select` structure, the code assigns specific values to `ax` based on the different combinations of the 3-bit input `B`.
3. The assignments for `ax` are as follows:
   - "10000000" when B = "000"
   - "01000000" when B = "001"
   - "00100000" when B = "010"
   - "00010000" when B = "011"
   - "00001000" when B = "100"
   - "00000100" when B = "110"
   - "00000010" for all other combinations of B
4. Finally, the output signal `C` is assigned the value of `ax` when the enable signal `A` is '0'. If `A` is '1', then `C` is set to "00000000".

## Decoder Output Truth Table
|  A  |  B[2]  |  B[1]  |  B[0]  |  C[7]  |  C[6]  |  C[5]  |  C[4]  |  C[3]  |  C[2]  |  C[1]  |  C[0]  |
|:---:|:------:|:------:|:------:|:------:|:------:|:------:|:------:|:------:|:------:|:------:|:------:|
|  0  |   0    |   0    |   0    |   1    |   0    |   0    |   0    |   0    |   0    |   0    |   0    |
|  0  |   0    |   0    |   1    |   0    |   1    |   0    |   0    |   0    |   0    |   0    |   0    |
|  0  |   0    |   1    |   0    |   0    |   0    |   1    |   0    |   0    |   0    |   0    |   0    |
|  0  |   0    |   1    |   1    |   0    |   0    |   0    |    1   |   0    |   0    |   0    |   0    |
|  0  |   1    |   0    |   0    |   0    |   0    |   0    |   0    |   1    |   0    |   0    |   0    |
|  0  |   1    |   0    |   1    |   0    |   0    |   0    |   0    |   0    |   1    |   0    |   0    |
|  0  |   1    |   1    |   0    |   0    |   0    |   0    |   0    |   0    |   0    |   1    |   0    |
|  1  |   X    |   X    |   X    |   0    |   0    |   0    |   0    |   0    |   0    |   0    |   0    |

## Usage

To use this code, follow these steps:

1. Create a new VHDL project in your preferred development environment.
2. Add the provided `dec3a8.vhd` file to the project.
3. Compile and analyze the code.
4. Simulate or implement the design using appropriate testbench or constraints.

## Compatibility

This VHDL code is compatible with any VHDL synthesis tool or simulator that supports VHDL-93 or later versions.

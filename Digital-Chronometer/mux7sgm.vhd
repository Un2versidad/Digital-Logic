----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.01.2023 16:08:29
-- Design Name: 
-- Module Name: mux7sgm - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux7sgm is
    Port ( clk100mhz : in STD_LOGIC;
           pto : in STD_LOGIC_VECTOR (3 downto 0);
           numero : in STD_LOGIC_VECTOR (15 downto 0);
           catodo : out STD_LOGIC_VECTOR (6 downto 0);
           display : out STD_LOGIC_VECTOR (3 downto 0);
           dp : out STD_LOGIC);
end mux7sgm;

architecture Behavioral of mux7sgm is

signal count : std_logic_vector(15 downto 0) := x"0000";
signal bcd : std_logic_vector(3 downto 0);

--BCD-to-seven-segment decoder
-- 
-- segment encoding
--      0
--     ---  
--  5 |   | 1
--     ---   <- 6
--  4 |   | 2
--     ---
--      3

begin

clk:    process(clk100mhz)
        begin
            if rising_edge (clk100mhz) then
                count <= count + '1';
            end if;
end process clk;

--------------- decodificador 7 segmentos-----------
with bcd select --   gfedcba
    catodo <=       "1000000"   when "0000",
                    "1111001"   when "0001",
                    "0100100"   when "0010",
                    "0110000"   when "0011",
                    "0011001"   when "0100",
                    "0010010"   when "0101",
                    "0000010"   when "0110",
                    "1111000"   when "0111",
                    "0000000"   when "1000",
                    "0010000"   when "1001",
                    "0001000"   when "1010",
                    "0000011"   when "1011",
                    "1000110"   when "1100",
                    "0100001"   when "1101",
                    "0000110"   when "1110",
                    "0001110"   when others;

-------------- Decodificador de 2 a 4 ---------------
with count(15 downto 14) select
    display <=  "1110"  when "00",
                "1101"  when "01",
                "1011"  when "10",
                "0111"  when others;

------- Multiplexor de 4 a 1 para el número ---------
with count(15 downto 14) select
    bcd  <=  numero(3 downto 0)   when "00",
             numero(7 downto 4)   when "01",
             numero(11 downto 8)  when "10",
             numero(15 downto 12) when others;
    
------- Multiplexor de 4 a 1 para el punto ----------
with count(15 downto 14) select
    dp <=   not pto(0)  when "00",
            not pto(1)  when "01",
            not pto(2)  when "10",
            not pto(3)  when others;
   
end Behavioral;
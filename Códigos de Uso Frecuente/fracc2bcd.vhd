----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:38:17 12/19/2019 
-- Design Name: 
-- Module Name:    fracc2bcd - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Este código sirve para interpretar los bits después del punto decimal en números enteros.  Los 16 bits de 
-- entrada es la parte decimal (a la derecha del punto decimal) de x número y la salida (decimal_bcd) serían el equivalente
-- en números enteros bcd de este número decimal.  El código se probó y funciona perfectamente.  
-- 
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

entity fracc2bcd is
    Port ( fraccion : in  STD_LOGIC_VECTOR (15 downto 0);
           decimal_bcd : out  STD_LOGIC_VECTOR (55 downto 0));      --usar los 16 bits más significativos (decimal_bcd(55:40))
end fracc2bcd;

architecture Behavioral of fracc2bcd is

constant cte1 : std_logic_vector(47 downto 0)  := x"2D79883D2000";
constant cte2 : std_logic_vector(47 downto 0)  := x"16BCC41E9000";
constant cte3 : std_logic_vector(43 downto 0)  := x"B5E620F4800";
constant cte4 : std_logic_vector(43 downto 0)  := x"5AF3107A400";
constant cte5 : std_logic_vector(43 downto 0)  := x"2D79883D200";
constant cte6 : std_logic_vector(43 downto 0)  := x"16BCC41E900";
constant cte7 : std_logic_vector(39 downto 0)  := x"B5E620F480";
constant cte8 : std_logic_vector(39 downto 0)  := x"5AF3107A40";
constant cte9 : std_logic_vector(39 downto 0)  := x"2D79883D20";
constant cte10 : std_logic_vector(39 downto 0) := x"16BCC41E90";
constant cte11 : std_logic_vector(35 downto 0) := x"B5E620F48";
constant cte12 : std_logic_vector(35 downto 0) := x"5AF3107A4";
constant cte13 : std_logic_vector(35 downto 0) := x"2D79883D2";
constant cte14 : std_logic_vector(35 downto 0) := x"16BCC41E9";
constant cte15 : std_logic_vector(31 downto 0) := x"B5E620F4";
constant cte16 : std_logic_vector(31 downto 0) := x"5AF3107A";

signal decimal1, decimal2 : std_logic_vector(47 downto 0);
signal decimal3, decimal4, decimal5, decimal6 : std_logic_vector(43 downto 0);
signal decimal7, decimal8, decimal9, decimal10 : std_logic_vector(39 downto 0);
signal decimal11, decimal12, decimal13, decimal14 : std_logic_vector(35 downto 0);
signal decimal15, decimal16 : std_logic_vector(31 downto 0);
signal decimal : std_logic_vector(55 downto 0);

COMPONENT BIN2BCDnDIGITS
    Generic ( n : integer);  											-- number of BCD digits
    Port ( BIN : in  STD_LOGIC_VECTOR (4*n-1 downto 0);
           BCD : out  STD_LOGIC_VECTOR (4*n-1 downto 0));
END COMPONENT;

begin

dec:  BIN2BCDnDIGITS GENERIC MAP (n => 14)
					 PORT MAP (decimal, decimal_bcd);

decimal1  <= x"000000000000"	when (fraccion(15) = '0') else cte1;
decimal2  <= x"000000000000"	when (fraccion(14) = '0') else cte2;
decimal3  <= x"00000000000"	    when (fraccion(13) = '0') else cte3;
decimal4  <= x"00000000000"	    when (fraccion(12) = '0') else cte4;
decimal5  <= x"00000000000"	    when (fraccion(11) = '0') else cte5;
decimal6  <= x"00000000000"	    when (fraccion(10) = '0') else cte6;
decimal7  <= x"0000000000"		when (fraccion(9)  = '0') else cte7;
decimal8  <= x"0000000000"		when (fraccion(8)  = '0') else cte8;
decimal9  <= x"0000000000"		when (fraccion(7)  = '0') else cte9;
decimal10 <= x"0000000000"		when (fraccion(6)  = '0') else cte10;
decimal11 <= x"000000000"		when (fraccion(5)  = '0') else cte11;
decimal12 <= x"000000000"		when (fraccion(4)  = '0') else cte12;
decimal13 <= x"000000000"		when (fraccion(3)  = '0') else cte13;
decimal14 <= x"000000000"		when (fraccion(2)  = '0') else cte14;
decimal15 <= x"00000000"		when (fraccion(1)  = '0') else cte15;
decimal16 <= x"00000000"		when (fraccion(0)  = '0') else cte16;

decimal <= (x"00" & decimal1) + decimal2 + decimal3 + decimal4 + decimal5 + decimal6 + decimal7 + decimal8 + decimal9 + 
				decimal10 + decimal11 + decimal12 + decimal13 + decimal14 + decimal15 + decimal16;
			  
end Behavioral;
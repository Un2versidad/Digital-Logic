----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2023 12:44:50
-- Design Name: 
-- Module Name: EdgeUpDn_deboun - Behavioral
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

entity EdgeUpDn_deboun is
    Port ( clk100mhz, d : in STD_LOGIC;
           qup_event, qdn_event : out STD_LOGIC);
end EdgeUpDn_deboun;

architecture Behavioral of EdgeUpDn_deboun is

CONSTANT REBOTE : STD_LOGIC_VECTOR (23 DOWNTO 0) := X"989680";				--10,000,000 -> REBOTE DE 100mseg

SIGNAL D_DELAY, DUP_EN, DDN_EN, dup_event, ddn_event : STD_LOGIC;
SIGNAL COUNT_UP, COUNT_DN : STD_LOGIC_VECTOR (23 DOWNTO 0) := X"000000";

begin

qup_event <= dup_event;
qdn_event <= ddn_event;

EVENTO:	PROCESS (clk100mhz)
		BEGIN
		IF clk100mhz'EVENT AND clk100mhz = '1' THEN
			D_DELAY <= d;
			IF DUP_EN = '1' AND DDN_EN = '1' THEN
				IF d = '1' AND D_DELAY = '0' THEN
					dup_event <= '1';
				ELSIF d = '0' AND D_DELAY = '1' THEN
					ddn_event <= '1';
				ELSE
					dup_event <= '0';
					ddn_event <= '0';
				END IF;
			ELSE
				dup_event <= '0';			--REDUNDANTE
				ddn_event <= '0';			--REDUNDANTE
			END IF;
		END IF;
END PROCESS EVENTO;

VALIDUP:	PROCESS (clk100mhz)
			BEGIN
			IF clk100mhz'EVENT AND clk100mhz = '1' THEN
				IF dup_event = '0' THEN
					COUNT_UP <= COUNT_UP + '1';
					IF COUNT_UP < REBOTE THEN
						DUP_EN <= '0';
					ELSE
						DUP_EN <= '1';
						COUNT_UP <= X"AAAAAA";
					END IF;
				ELSE
					COUNT_UP <= X"000000";
				END IF;
			END IF;
END PROCESS VALIDUP;	

VALIDDN:	PROCESS (clk100mhz)
			BEGIN
			IF clk100mhz'EVENT AND clk100mhz = '1' THEN
				IF ddn_event = '0' THEN
					COUNT_DN <= COUNT_DN + '1';
					IF COUNT_DN < REBOTE THEN
						DDN_EN <= '0';
					ELSE
						DDN_EN <= '1';
						COUNT_DN <= X"AAAAAA";
					END IF;
				ELSE
					COUNT_DN <= X"000000";
				END IF;
			END IF;
END PROCESS VALIDDN;	
end Behavioral;
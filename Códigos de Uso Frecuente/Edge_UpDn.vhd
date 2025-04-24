----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.08.2021 14:04:20
-- Design Name: 
-- Module Name: Edge_UpDn - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Cuando la se�al de entrada "up" tiene asignado un '1', este c�digo reflejar� en la se�al Q un '1' durante un ciclo de reloj ->
--              el instante en el que la se�al D tuvo un flanco de subida. Si up = '0', entonces Q reflejar� un flanco de bajada en D.
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Edge_UpDn is
    Port ( clk, up, D : in STD_LOGIC;
           Q : out STD_LOGIC);
end Edge_UpDn;

architecture Behavioral of Edge_UpDn is

signal D_delay : STD_LOGIC;

begin

process (clk)
begin
	if rising_edge(clk) then
		D_delay <= D;
		if D = up and D_DELAY = not up then		-- cuando la se�al de entrada "up" tiene asignado un '1', este c�digo reflejar� en
			Q <= '1';							-- la se�al Q un '1' durante un ciclo de reloj el instante en el que la se�al D 
		else 									-- tuvo un flanco de subida. Si up = '0', entonces Q reflejar� un flanco de bajada
			Q <= '0';							-- en D
		end if;
	end if;
end process;
end Behavioral;
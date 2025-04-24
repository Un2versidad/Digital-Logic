----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:32:45 09/30/2013 
-- Design Name: 
-- Module Name:    BIN2BCDnDIGITS - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BIN2BCDnDIGITS is
    Generic ( n : integer := 2);  											-- number of BCD digits
    Port ( BIN : in  STD_LOGIC_VECTOR (4*n-1 downto 0);
           BCD : out  STD_LOGIC_VECTOR (4*n-1 downto 0));
end BIN2BCDnDIGITS;

architecture Behavioral of BIN2BCDnDIGITS is

procedure DecAdj(Ain : in std_logic_vector(4*n-1 downto 0);
                 Aout : out std_logic_vector(4*n-1 downto 0)) is 
variable Ainternal: std_logic_vector(4*n downto 0);  
begin
  Ainternal :=	'0' & Ain;
    for i in 0 to n-1 loop
      if Ainternal(4*i+3 downto 4*i)> "1001" then
		   Ainternal(4*i+4) := '1';
		end if;
      if Ainternal(4*i+4) = '1'	then	
        Ainternal(4*i+3 downto 4*i) := Ainternal(4*i+3 downto 4*i) + "0110";
      end if;		  
    end loop;		
    Aout := Ainternal(4*n-1 downto 0);
  end DecAdj;
  
begin
	process(BIN) is
   variable bcdInternal: STD_LOGIC_VECTOR (4*n-1 downto 0);
   begin
		bcdInternal := (others => '0');
		for j in 0 to 4*n-1 loop
			bcdInternal := (bcdInternal(4*n-1-1 downto 0) & BIN(4*n-1-j)); 
			DecAdj(Ain => bcdInternal, Aout => bcdInternal);
		end loop;
      BCD <= bcdInternal;
 end process;
 end Behavioral;


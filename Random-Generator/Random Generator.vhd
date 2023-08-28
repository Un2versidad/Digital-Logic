library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RandomGenerator is
  generic (
    SEED_WIDTH : positive := 8
  );
  port (
    clk      : in  std_logic;
    reset    : in  std_logic;
    random   : out std_logic_vector(SEED_WIDTH - 1 downto 0)
  );
end RandomGenerator;

architecture Behavioral of RandomGenerator is
  signal seed   : std_logic_vector(SEED_WIDTH - 1 downto 0);
  signal next_seed : std_logic_vector(SEED_WIDTH - 1 downto 0);
begin
  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        seed <= (others => '0');  -- Inicializar la semilla en cero
      else
        next_seed <= seed;
        next_seed(seed'high downto seed'high-2) <= next_seed(seed'high-1 downto seed'high-3) xor next_seed(seed'high-2 downto seed'high-4);
        seed <= next_seed;
      end if;
    end if;
  end process;

  random <= seed;
end Behavioral;
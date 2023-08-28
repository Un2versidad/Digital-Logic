library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity notas_musicales is
    Port ( 
        sw : in STD_LOGIC_VECTOR (7 downto 0);
        clk100mhz : in STD_LOGIC;
        speaker : out STD_LOGIC
    );
end notas_musicales;

architecture Behavioral of notas_musicales is
    signal audio_do : std_logic;
    signal audio_re : std_logic;
    signal audio_mi : std_logic;
    signal audio_fa : std_logic;
    signal audio_sol : std_logic;
    signal audio_la : std_logic;
    signal audio_si : std_logic;
    signal audio_do8va : std_logic;

    constant do : integer := 764457;
    constant re : integer := 681059;
    constant mi : integer := 606716;
    constant fa : integer := 572687;
    constant sol : integer := 510204;
    constant la : integer := 454545;
    constant si : integer := 405797;
    constant do8va : integer := 382228;

    signal counter_do : integer range 0 to 268435455 := 0;
    signal counter_re : integer range 0 to 268435455 := 0;
    signal counter_mi : integer range 0 to 268435455 := 0;
    signal counter_fa : integer range 0 to 268435455 := 0;
    signal counter_sol : integer range 0 to 268435455 := 0;
    signal counter_la : integer range 0 to 268435455 := 0;
    signal counter_si : integer range 0 to 268435455 := 0;
    signal counter_do8va : integer range 0 to 268435455 := 0;    
begin
   -- do
    process (clk100mhz)
    begin
        if rising_edge(clk100mhz) then
            counter_do <= counter_do + 1;
            if counter_do = do then
                audio_do <= not audio_do;
                counter_do <= 0;
            end if;
        end if;
    end process;
    
    -- re
    process (clk100mhz)
    begin
        if rising_edge(clk100mhz) then
            counter_re <= counter_re + 1;
            if counter_re = re then
                audio_re <= not audio_re;
                counter_re <= 0;
            end if;
        end if;
    end process;
    
    -- mi
    process (clk100mhz)
    begin
        if rising_edge(clk100mhz) then
            counter_mi <= counter_mi + 1;
            if counter_mi = mi then
                audio_mi <= not audio_mi;
                counter_mi <= 0;
            end if;
        end if;
    end process;
    
    process (clk100mhz)
    begin
        if rising_edge(clk100mhz) then
            counter_fa <= counter_fa + 1;
            if counter_fa = fa then
                audio_fa <= not audio_fa;
                counter_fa <= 0;
            end if;
        end if;
    end process;
    
    process (clk100mhz)
    begin
        if rising_edge(clk100mhz) then
            counter_sol <= counter_sol + 1;
            if counter_sol = sol then
                audio_sol <= not audio_sol;
                counter_sol <= 0;
            end if;
        end if;
    end process;
    
    process (clk100mhz)
    begin
        if rising_edge(clk100mhz) then
            counter_la <= counter_la + 1;
            if counter_la = la then
                audio_la <= not audio_la;
                counter_la <= 0;
            end if;
        end if;
    end process;
    
    process (clk100mhz)
    begin
        if rising_edge(clk100mhz) then
            counter_si <= counter_si + 1;
            if counter_si = si then
                audio_si <= not audio_si;
                counter_si <= 0;
            end if;
        end if;
    end process;
    
    process (clk100mhz)
    begin
        if rising_edge(clk100mhz) then
            counter_do8va <= counter_do8va + 1;
            if counter_do8va = do8va then
                audio_do8va <= not audio_do8va;
                counter_do8va <= 0;
            end if;
        end if;
    end process;
  
    with sw select
        speaker <= audio_do when "00000001",
                   audio_re when "00000010",
                   audio_mi when "00000100",
                   audio_fa when "00001000",
                   audio_sol when "00010000",
                   audio_la when "00100000",
                   audio_si when "01000000",
                   audio_do8va when "10000000",
                   '0' when others;
end Behavioral;
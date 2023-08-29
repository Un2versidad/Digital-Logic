-- This VHDL code describes a digital stopwatch that displays the elapsed time on a 7-segment display. 
-- The stopwatch is controlled by a 100MHz clock signal and has three inputs: start_stop, reset, and clk100mhz. 
-- The start_stop input starts and stops the stopwatch, the reset input resets the stopwatch to zero, and the clk100mhz input is the clock signal. 
-- The stopwatch displays the elapsed time in centiseconds, deciseconds, seconds, and decaseconds on a 7-segment display. 
-- The elapsed time is also displayed on four LEDs. 
-- The code uses a component called mux7sgm to display the elapsed time on the 7-segment display. 
-- The code uses several signals to keep track of the elapsed time and to control the display. 
-- The code uses two processes to control the stopwatch and the display. 
-- The first process generates a 1Hz clock signal from the 100MHz clock signal. 
-- The second process controls the stopwatch and updates the display. 
-- The code is written in VHDL and is intended to be synthesized and implemented on an FPGA.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity digital_stopwatch is
    port (
        clk100mhz : in std_logic;
        start_stop : in std_logic;
        reset : in std_logic;
        catodo : out std_logic_vector(6 downto 0);
        display, led : out std_logic_vector(3 downto 0)
     );
end digital_stopwatch;

architecture Behavioral of digital_stopwatch is

    component mux7sgm
    Port ( clk100mhz : in STD_LOGIC;
           pto : in STD_LOGIC_VECTOR (3 downto 0);
           numero : in STD_LOGIC_VECTOR (15 downto 0);
           catodo : out STD_LOGIC_VECTOR (6 downto 0);
           display : out STD_LOGIC_VECTOR (3 downto 0);
           dp : out STD_LOGIC);
    end component;

    constant half_period : integer := 499999;
    signal led_on : std_logic_vector(3 downto 0);
    signal stopwatch_value : std_logic_vector(15 downto 0) := x"0000";
    signal count : integer range 0 to 524287:= 0;
    signal count_centisecond : integer  range 0 to 15:= 0;
    signal count_deci_second : integer  range 0 to 15:= 0;
    signal count_second : integer  range 0 to 15:= 0;
    signal count_deca_second : integer  range 0 to 7:= 0;
    signal clk_1hz : std_logic;
    Signal clk_2 : std_logic;

begin

    process (clk100mhz)
    begin
        clk_1hz <= clk_2;
        if rising_edge(clk100mhz) then
            count <= count + 1;
            if count = half_period then
                clk_2 <= not clk_2;
                count <= 0;
            end if;
        end if;
    end process;

    clk: process(clk_1hz)
    begin
        led <= led_on;
        if reset = '1' then
            led_on <="0000";
            stopwatch_value <= x"0000";
            count_centisecond <= 0;
            count_deci_second <= 0;
            count_second <= 0;
            count_deca_second <= 0;
        elsif rising_edge (clk_1hz) then
            if start_stop = '1' then
                count_centisecond <= count_centisecond + 1;
                if count_centisecond = 9 then
                    count_centisecond <= 0;
                    count_deci_second  <= count_deci_second + 1;
                    stopwatch_value(3 downto 0) <= "0000";
                    stopwatch_value(7 downto 4) <= stopwatch_value(7 downto 4) + "0001";
                    if count_deci_second = 9 then
                        count_deci_second <= 0;
                        count_second <= count_second +1;
                        stopwatch_value(7 downto 4) <= "0000";
                        stopwatch_value(11 downto 8) <= stopwatch_value(11 downto 8) + "0001";
                        if count_second = 9 then
                            count_second  <= 0;
                            count_deca_second <= count_deca_second + 1;
                            stopwatch_value(11 downto 8) <= "0000";
                            stopwatch_value(15 downto 12) <= stopwatch_value(15 downto 12) + "0001"; 
                            if count_deca_second = 5 then
                                count_deca_second <= 0;
                                stopwatch_value  <= x"0000";
                                led_on <= led_on + '1';
                            end if;
                        end if;
                    end if;
                else 
                    stopwatch_value <= stopwatch_value + '1';
                end if;
            end if;
        end if;
    end process clk;

    display_7seg: mux7sgm 
        port map (
            clk100mhz => clk100mhz,
            pto => "0000",
            numero => stopwatch_value,
            catodo => catodo,
            display => display,
            dp => open
        );
end Behavioral;

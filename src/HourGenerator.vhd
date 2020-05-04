-- Mark Wilkinson
-- Minute Generator

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity HourGenerator is
  port (
    hour_tick_in: in std_logic;
    button: in std_logic;
    hour_number_out: out std_logic_vector(5 downto 0)
  );
end entity HourGenerator;

architecture Logic of HourGenerator is
  signal clk: std_logic;
begin
  clk <= button or hour_tick_in;
  count_process: process(clk)
	  variable count: std_logic_vector(5 downto 0) := "001100";
  begin
    if rising_edge(clk) then
      if (count = "001100") then -- if at 12
        count := "000001";
      else
        count := count + '1';      
      end if;
    end if;
    hour_number_out <= count;
  end process count_process;  
end architecture Logic;

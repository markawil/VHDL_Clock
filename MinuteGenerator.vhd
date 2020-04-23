-- Mark Wilkinson
-- EE5143 Final Project
-- Minute Generator

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity MinuteGenerator is
  port (
    minute_tick_in: in std_logic;
    hour_tick_out: out std_logic;
    minute_number_out: out std_logic_vector(5 downto 0)
  );
end entity MinuteGenerator;

architecture Logic of MinuteGenerator is
begin
  count_process: process(minute_tick_in)
	variable count: std_logic_vector(5 downto 0);
  begin
    if rising_edge(minute_tick_in) then
      count := count + '1'; -- legal VHDL to increment a std_logic_vector
      if (count = "111100") then -- if count is 60, start over
        hour_tick_out <= '1';
        count := "000000";
      else
        hour_tick_out <= '0';
      end if;
    end if;    
    minute_number_out <= count;
  end process count_process;  
end architecture Logic;
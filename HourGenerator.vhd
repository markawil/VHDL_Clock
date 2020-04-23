-- Mark Wilkinson
-- EE5143 Final Project
-- Minute Generator

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity HourGenerator is
  port (
    hour_tick_in: in std_logic;
    hour_number_out: out std_logic_vector(5 downto 0)
  );
end entity HourGenerator;

architecture Logic of HourGenerator is
begin
  count_process: process(hour_tick_in)
	variable count: std_logic_vector(5 downto 0) := "001100";
  begin
    if rising_edge(hour_tick_in) then
      if (count = "001100") then -- if at 12
        count := "000001";
      else
        count := count + '1';      
      end if;
    end if;
    hour_number_out <= count;
  end process count_process;  
end architecture Logic;

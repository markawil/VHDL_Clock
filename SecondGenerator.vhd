-- Mark Wilkinson
-- EE5143 Final Project
-- Second Generator

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity SecondGenerator is
  port (
    tick_in: in std_logic;
    minute_tick_out: out std_logic;
    second: out std_logic_vector(5 downto 0)
  );
end entity SecondGenerator;

architecture Logic of SecondGenerator is
begin
  count_process: process(tick_in)
	  variable count: std_logic_vector(5 downto 0);
  begin    
    if rising_edge(tick_in) then
      count := count + '1'; -- legal VHDL to increment a std_logic_vector
      if (count = "111100") then -- if count is 60, start over
        minute_tick_out <= '1';
        count := "000000";
      else 
			  minute_tick_out <= '0';
		  end if;
    end if;
    second <= count;
  end process count_process;    
end architecture Logic;


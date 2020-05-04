-- Mark Wilkinson
-- Minute Generator

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity ButtonDriver is
  port (
    switch_pair : in std_logic_vector(1 downto 0);
    minute_add_out : out std_logic;
    hour_add_out : out std_logic
  );
end entity ButtonDriver;

architecture RTL of ButtonDriver is
begin
  minute_add_out <= not (switch_pair(0));
  hour_add_out <= not (switch_pair(1));  
end architecture RTL;
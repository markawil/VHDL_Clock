-- Mark Wilkinson
-- EE5143 Final Project
-- Tick Generator

-- The TickGenerator takes in the 50 MHz clock and generates a 1 Hz output clock 
-- essentially generating second ticks. Its output can drive a second-by-second blinking LED. 
-- Additionally, the output tick_out is also sent to the SecondGenerator block.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity TickGenerator is
  port (
    Clk_50MHz: in std_logic;
    tick_out: out std_logic
  );
end entity TickGenerator;

architecture Logic of TickGenerator is 
begin
  clock_process: process(Clk_50MHz)
	variable scaler : natural; 
	variable pulse : std_logic;
  begin
    if rising_edge(Clk_50MHz) then
      if (scaler < (25000000-1)) then -- to out a 1 Hz pulse
          scaler := scaler + 1; 
      else
        scaler := 0;
        pulse := not(pulse);
      end if;
    end if;
    tick_out <= pulse; -- signifies a second tick
  end process clock_process;  
end architecture Logic;
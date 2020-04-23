-- Mark Wilkinson
-- EE5143 Final Project
-- Scan Clock

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity ScanClock is
  port (
    clk_50MHz: in std_logic;
    scan_out: out std_logic
  );
end entity ScanClock;

architecture RTL of ScanClock is
begin
  clk_out_process: process(clk_50Mhz)
   variable scaler : natural; 
	variable pulse : std_logic;
  begin
    if rising_edge(clk_50Mhz) then
      if (scaler < (50000-1)) then -- send out a pulse at 500 Hz
          scaler := scaler + 1; 
      else
        scaler := 0;
        pulse := not(pulse);
      end if;
    end if;
    scan_out <= pulse;
  end process clk_out_process;
end architecture RTL;
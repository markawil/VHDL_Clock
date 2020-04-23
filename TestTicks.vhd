-- Mark Wilkinson
-- EE5143 Final Project
-- Temp tester for tick, second and minute generators.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity TestTicks is
  port (
    clk: in std_logic;
    s_out: out std_logic;
    m_out: out std_logic
  );
end entity TestTicks;

architecture RTL of TestTicks is

  signal tick_to_second: std_logic; -- internal tick signal from tick_generator to second_generator

  component TickGenerator
    port(Clk_50MHz: in std_logic; 
	      tick_out: out std_logic);
  end component;

  component SecondGenerator
    port(tick_in: in std_logic; 
	      minute_tick: out std_logic);
  end component;

begin

	s_out <= tick_to_second;
	C1: TickGenerator port map(Clk_50MHz => clk, tick_out => tick_to_second);
	C2: SecondGenerator port map(tick_in => tick_to_second, minute_tick => m_out);
  
end architecture RTL;
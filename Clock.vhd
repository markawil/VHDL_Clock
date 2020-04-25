-- Mark Wilkinson
-- EE5143 Final Project
-- Clock System 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- the actual inputs and outputs for the system as a whole
entity Clock is
  port (
    clk_50: in std_logic;
    buttons: in std_logic_vector(1 downto 0);
    second_blink: out std_logic;  -- needed to blink the : in the clock display
    digit_vector_out: out std_logic_vector(3 downto 0); -- which digit to currently show
    display_clock_out: out std_logic_vector(6 downto 0) -- which segments to light up
  );
end entity Clock;

architecture RTL of Clock is

  -- internal signals for the system
  signal tick_to_second: std_logic;
  signal scan_signal: std_logic;
  signal minute_tick: std_logic;
  signal button_minute: std_logic;
  signal button_hour: std_logic;
  signal hour_tick: std_logic;
  signal minute_to_dd: std_logic_vector(5 downto 0);
  signal hour_to_dd: std_logic_vector(5 downto 0);
  signal minute_ones_to_driver: std_logic_vector(3 downto 0);
  signal minute_tens_to_driver: std_logic_vector(3 downto 0);
  signal hour_ones_to_driver: std_logic_vector(3 downto 0);
  signal hour_tens_to_driver: std_logic_vector(3 downto 0);

  -- components that make up the system
  component TickGenerator
    port(Clk_50MHz: in std_logic; 
	      tick_out: out std_logic);
  end component;

  component ScanClock
    port(clk_50MHz: in std_logic;
        scan_out: out std_logic);
  end component;

  component ButtonDriver
    port(switch_pair: in std_logic_vector(1 downto 0);
         minute_add_out: out std_logic;
         hour_add_out: out std_logic);
  end component;

  component SecondGenerator
    port(tick_in: in std_logic; 
	      minute_tick_out: out std_logic);
  end component;

  component MinuteGenerator
    port(minute_tick_in: in std_logic;
		    button: in std_logic;
        hour_tick_out: out std_logic;
        minute_number_out: out std_logic_vector(5 downto 0));
  end component;

  component HourGenerator
    port(hour_tick_in: in std_logic;
        button: in std_logic;
        hour_number_out: out std_logic_vector(5 downto 0));
  end component;

  component DoubleDabble
    port(count: in std_logic_vector(5 downto 0);
        ones: out std_logic_vector(3 downto 0);
        tens: out std_logic_vector(3 downto 0));
  end component;

  component DisplayDriver
    port(
      scan_clk: in std_logic;
      min_ones: in std_logic_vector(3 downto 0);
      min_tens: in std_logic_vector(3 downto 0);
      hour_ones: in std_logic_vector(3 downto 0);
      hour_tens: in std_logic_vector(3 downto 0);
      digit_out: out std_logic_vector(3 downto 0);
      display_out: out std_logic_vector(6 downto 0));
  end component;

begin
  
  second_blink <= tick_to_second;
  C1: TickGenerator port map(Clk_50MHz => clk_50, tick_out => tick_to_second);
  C2: SecondGenerator port map(tick_in => tick_to_second, minute_tick_out => minute_tick);
  C3: MinuteGenerator port map(minute_tick_in => minute_tick, button => button_minute, hour_tick_out => hour_tick, minute_number_out => minute_to_dd);
  C4: HourGenerator port map(hour_tick_in => hour_tick, button => button_hour, hour_number_out => hour_to_dd);
  C5: DoubleDabble port map(count => minute_to_dd, ones => minute_ones_to_driver, tens => minute_tens_to_driver);
  C6: DoubleDabble port map(count => hour_to_dd, ones => hour_ones_to_driver, tens => hour_tens_to_driver);
  C7: ScanClock port map(clk_50MHz => clk_50, scan_out => scan_signal);
  C8: DisplayDriver port map(scan_clk => scan_signal, min_ones => minute_ones_to_driver, min_tens => minute_tens_to_driver,
                              hour_ones => hour_ones_to_driver, hour_tens => hour_tens_to_driver,
                              digit_out => digit_vector_out, display_out => display_clock_out);
  C9: ButtonDriver port map(switch_pair => buttons, minute_add_out => button_minute, hour_add_out => button_hour);

end architecture RTL;
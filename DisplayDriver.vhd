-- Mark Wilkinson
-- EE5143 Final Project
-- Display Driver block

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

 entity DisplayDriver is
   port (
     scan_clk: in std_logic; -- 500 Hz signal
     min_ones: in std_logic_vector(3 downto 0);
     min_tens: in std_logic_vector(3 downto 0);
     hour_ones: in std_logic_vector(3 downto 0);
     hour_tens: in std_logic_vector(3 downto 0);
     digit_vector: out std_logic_vector(3 downto 0); -- which digit to currently show
     display_out: out std_logic_vector(6 downto 0) -- which segments to light up
   );
 end entity DisplayDriver;

 architecture RTL of DisplayDriver is
  
  -- function that converts the 4 digit binary number into a 7-segment display vector
  function bin_to_7segment(binNum : std_logic_vector(3 downto 0)) 
      return std_logic_vector is
      variable temp: std_logic_vector(6 downto 0);
    begin
      case binNum is
        when "0000" => temp := "0111111"; -- 0 g,f,e,d,c,b,a
        when "0001" => temp := "0000110"; -- 1
        when "0010" => temp := "1011011"; -- 2
        when "0011" => temp := "1001111"; -- 3
        when "0100" => temp := "1100110"; -- 4
        when "0101" => temp := "1101101"; -- 5
        when "0110" => temp := "1111101"; -- 6
        when "0111" => temp := "0000111"; -- 7
        when "1000" => temp := "1111111"; -- 8
        when "1001" => temp := "1101111"; -- 9
        when others  => temp := "0000000"; -- invalid, used to hide the 0 if needed
      end case;
      return std_logic_vector(temp);
  end function;

 begin
    -- main process that determines both which digit to select and 
    -- what 7-segment number to send
    display_process: process(scan_clk)
      --variable period_count: natural range 1 to 5 := 1;
      variable digit: natural range 1 to 4 := 1;
    begin
      if rising_edge(scan_clk) then
        --if period_count = 5 then -- wait until 5 to actually do everything
          --period_count := 1;
          -- select the current digit and send out the
          -- 7-segment signal
          case digit is
            when 1 => 
				  digit_vector <= "0001";
              display_out <= bin_to_7segment(min_ones);
				  --display_out <= "0000110";
            when 2 => 
              digit_vector <= "0010";
              display_out <= bin_to_7segment(min_tens);
				  --display_out <= "0111111";
            when 3 => 
				  digit_vector <= "0100";
              display_out <= bin_to_7segment(hour_ones);
				  --display_out <= "0000110";
            when 4 => 
              digit_vector <= "1000";
              if (hour_tens = "0000") then
                display_out <= bin_to_7segment("1111"); -- instruct function to turn off all digits
              else 
                display_out <= bin_to_7segment(hour_tens);
              end if;
          end case;

          -- increment to the next digit
          if digit = 4 then
            digit := 1;
          else
            digit := digit + 1;
          end if;       
           
        --end if;
      end if;
    end process display_process;
 end architecture RTL;

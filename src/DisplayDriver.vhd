-- Mark Wilkinson
-- Display Driver block

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

 entity DisplayDriver is
   port (
     scan_clk: in std_logic;
     min_ones: in std_logic_vector(3 downto 0);
     min_tens: in std_logic_vector(3 downto 0);
     hour_ones: in std_logic_vector(3 downto 0);
     hour_tens: in std_logic_vector(3 downto 0);
     digit_out: out std_logic_vector(3 downto 0);
     display_out: out std_logic_vector(6 downto 0)
   );
 end entity DisplayDriver;

 architecture RTL of DisplayDriver is
  
  -- using a function to convert each binary segment to the
  -- right set of digits rather than doing this each time inside
  -- the case statement of the process.
  function sevenSegment(binNum : std_logic_vector(3 downto 0)) 
      return std_logic_vector is
      variable temp: std_logic_vector(6 downto 0);
    begin
	 
		-- going with the orientation for the digits as: g,f,e,d,c,b,a
      case binNum is
        when "0000" => temp := "0111111"; -- 0
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
    main_proc: process(scan_clk)

      variable digit: natural range 1 to 4 := 1;
    begin
      if rising_edge(scan_clk) then
        
          -- select the current digit and send out the
          -- 7-segment signal
          case digit is
            when 1 => 
				  display_out <= sevenSegment(min_ones);	
				  digit_out <= "0001";
            when 2 => 
				  display_out <= sevenSegment(min_tens);
              digit_out <= "0010";              
            when 3 => 
              display_out <= sevenSegment(hour_ones);
				  digit_out <= "0100";
            when 4 => 
              digit_out <= "1000";
				  -- requirement to not show the hours-tens digit if it's zero
              if (hour_tens = "0000") then
                display_out <= sevenSegment("1111"); -- instruct function to turn off all digits
              else 
                display_out <= sevenSegment(hour_tens);
              end if;
          end case;

          if digit = 4 then
            digit := 1;
          else
            digit := digit + 1;
          end if;       
           
      end if;
    end process main_proc;
 end architecture RTL;

-- Mark Wilkinson
-- DoubleDabble block
	
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity DoubleDabble is
  port (
    count: in std_logic_vector(5 downto 0);
    ones: out std_logic_vector(3 downto 0);
    tens: out std_logic_vector(3 downto 0)
  );
end entity DoubleDabble;

architecture Logic of DoubleDabble is

  function bin_to_BCD(binNum : std_logic_vector(5 downto 0)) 
      return std_logic_vector is
      
      -- local variables to the function
      variable temp_integer: integer := 0;
      variable temp_ones: std_logic_vector(3 downto 0);
      variable temp_tens: std_logic_vector(3 downto 0);
      variable temp_return: std_logic_vector(7 downto 0);

    begin
      -- converts the binary to a usable integer
      temp_integer := to_integer(unsigned(binNum));

      case temp_integer is
        when 0 to 9 =>
          temp_ones := binNum(3 downto 0);
          temp_tens := "0000";
        when 10 to 19 =>
          temp_integer := temp_integer - 10;
          temp_ones := std_logic_vector(to_unsigned(temp_integer, temp_ones'length));
          temp_tens := "0001";
        when 20 to 29 =>
          temp_integer := temp_integer - 20;
          temp_ones := std_logic_vector(to_unsigned(temp_integer, temp_ones'length));
          temp_tens := "0010";
        when 30 to 39 =>
          temp_integer := temp_integer - 30;
          temp_ones := std_logic_vector(to_unsigned(temp_integer, temp_ones'length));
          temp_tens := "0011";
        when 40 to 49 =>
          temp_integer := temp_integer - 40;
          temp_ones := std_logic_vector(to_unsigned(temp_integer, temp_ones'length));
          temp_tens := "0100";
        when 50 to 59 =>
          temp_integer := temp_integer - 50;
          temp_ones := std_logic_vector(to_unsigned(temp_integer, temp_ones'length));
          temp_tens := "0101";
        when others =>
          temp_ones := "0000";
          temp_tens := "0000";
      end case;

      temp_return(7 downto 4) := temp_tens;
      temp_return(3 downto 0) := temp_ones;
      
      return std_logic_vector(temp_return);
  end function;

  -- architecture begin
  begin
  process_count: process(count)
    variable temp_vector: std_logic_vector(5 downto 0);
    variable out_vector: std_logic_vector(7 downto 0);
  begin

    temp_vector(5 downto 0) := count;

    -- went with an understandable solution to me for getting the digits correct
    -- I could not get the DoubleDabble wikipedia algorithms working right with our 
    -- requirement of only 2 digits and a max of 59, so this was my solution:

    out_vector := bin_to_BCD(temp_vector);
    
    -- set the outputs
    ones <= std_logic_vector(out_vector(3 downto 0));
    tens <= std_logic_vector(out_vector(7 downto 4));

  end process process_count;

end architecture Logic;
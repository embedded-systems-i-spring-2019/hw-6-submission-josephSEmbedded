----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2019 05:00:01 PM
-- Design Name: 
-- Module Name: exerc_2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity exerc_2 is
    Port (signal X1 : in std_logic;
          signal X2 : in std_logic;
          signal clk : in std_logic;
          signal Y : out std_logic_vector(1 downto 0);
          signal Z : out std_logic );
end exerc_2;

architecture Behavioral of exerc_2 is
    type state_type is (ST0,ST1,ST2);
    signal PS,NS : state_type;
begin
    sync_proc:process(clk)
    begin
        if(rising_edge(clk)) then PS <= NS;
        end if;
    end process sync_proc;
    
    comb_proc:process(PS,X1,X2)
    begin
        Z <= '0';
        case PS is 
            when ST0 => 
                if(X2 = '0') then Z<='1'; NS <= ST1;
                else Z<='0'; NS <= ST2; end if;
            when ST1 =>
                if(X1 = '1') then Z<='0'; NS <= ST0;
                else Z <= '0'; NS <= ST1; end if;
            when ST2 =>
                if(X2 = '0') then Z <= '1'; NS <= ST1;
                else Z<='0'; NS<=ST2; end if;
            when others =>
                Z <= '0'; NS<=ST1;
         end case;
    end process comb_proc;
    
with PS select
      Y <= "01" when ST0,
           "10" when ST1,
           "11" when ST2,
           "00" when others;
end Behavioral;

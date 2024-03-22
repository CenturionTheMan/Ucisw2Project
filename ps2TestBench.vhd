--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:24:41 03/20/2024
-- Design Name:   
-- Module Name:   D:/Ucisw2Project/ps2TestBench.vhd
-- Project Name:  Ucisw2Project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PS2_Rx_Module
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ps2TestBench IS
END ps2TestBench;
 
ARCHITECTURE behavior OF ps2TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PS2_Rx_Module
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         PS2_CLK : IN  std_logic;
         PS2_DATA : IN  std_logic;
         DATA_OUT : OUT  std_logic_vector(7 downto 0);
         DATA_READY : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal PS2_CLK : std_logic := '1';
   signal PS2_DATA : std_logic := '1';

 	--Outputs
   signal DATA_OUT : std_logic_vector(7 downto 0);
   signal DATA_READY : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PS2_Rx_Module PORT MAP (
          CLK => CLK,
          RESET => RESET,
          PS2_CLK => PS2_CLK,
          PS2_DATA => PS2_DATA,
          DATA_OUT => DATA_OUT,
          DATA_READY => DATA_READY
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

      PROCESS
		procedure TransmPS2( Byte : std_logic_vector( 7 downto 0 ) ) is
		  variable Frame : std_logic_vector( 10 downto 0 ) := "11" & Byte & '0';
		begin
		  -- Parity calculation
		  for i in 0 to 7 loop
			Frame( 9 ) := Frame( 9 ) xor Byte( i );
		  end loop;
		  -- Transmission of the frame; Fclk = 10kHz
		  for i in 0 to 10 loop
			PS2_Data <= Frame( i );
			wait for 5 us;
			PS2_Clk <= '0', '1' after 50 us;
			wait for 95 us;
		  end loop;
		end procedure;
	BEGIN
		wait for 15 us;
		TransmPS2( X"F0" );
		wait for 200 us;
		TransmPS2( X"81" );
		wait; -- will wait forever
	END PROCESS;


END;
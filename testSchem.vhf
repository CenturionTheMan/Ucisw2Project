--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : testSchem.vhf
-- /___/   /\     Timestamp : 03/21/2024 13:21:16
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -sympath "C:/Users/lab/Czw1115/Ucisw2Project/RS232 (1)" -intstyle ise -family spartan3e -flat -suppress -vhdl C:/Users/lab/Czw1115/Ucisw2Project/testSchem.vhf -w C:/Users/lab/Czw1115/Ucisw2Project/testSchem.sch
--Design Name: testSchem
--Device: spartan3e
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity testSchem is
   port ( BTN_SOUTH : in    std_logic; 
          Clk_50MHz : in    std_logic; 
          PS2_Clk   : in    std_logic; 
          PS2_Data  : in    std_logic; 
          RS232_RxD : in    std_logic; 
          RS232_TxD : out   std_logic);
end testSchem;

architecture BEHAVIORAL of testSchem is
   signal XLXN_1    : std_logic_vector (7 downto 0);
   signal XLXN_2    : std_logic;
   component RS232
      port ( Clk_50MHz : in    std_logic; 
             Reset     : in    std_logic; 
             RS232_RxD : in    std_logic; 
             TxStart   : in    std_logic; 
             TxDI      : in    std_logic_vector (7 downto 0); 
             TxBusy    : out   std_logic; 
             RxRdy     : out   std_logic; 
             RS232_TxD : out   std_logic; 
             RxDO      : out   std_logic_vector (7 downto 0); 
             Clk_Sys   : in    std_logic);
   end component;
   
   component PS2_Rx_Module
      port ( CLK        : in    std_logic; 
             RESET      : in    std_logic; 
             PS2_CLK    : in    std_logic; 
             PS2_DATA   : in    std_logic; 
             DATA_READY : out   std_logic; 
             DATA_OUT   : out   std_logic_vector (7 downto 0));
   end component;
   
begin
   XLXI_1 : RS232
      port map (Clk_Sys=>Clk_50MHz,
                Clk_50MHz=>Clk_50MHz,
                Reset=>BTN_SOUTH,
                RS232_RxD=>RS232_RxD,
                TxDI(7 downto 0)=>XLXN_1(7 downto 0),
                TxStart=>XLXN_2,
                RS232_TxD=>RS232_TxD,
                RxDO=>open,
                RxRdy=>open,
                TxBusy=>open);
   
   XLXI_2 : PS2_Rx_Module
      port map (CLK=>Clk_50MHz,
                PS2_CLK=>PS2_Clk,
                PS2_DATA=>PS2_Data,
                RESET=>BTN_SOUTH,
                DATA_OUT(7 downto 0)=>XLXN_1(7 downto 0),
                DATA_READY=>XLXN_2);
   
end BEHAVIORAL;



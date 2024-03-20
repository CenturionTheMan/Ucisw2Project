library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; --- check
use ieee.std_logic_signed.all; --- check

entity PS2_Rx_Module is
    Port ( CLK : in  STD_LOGIC;
			  RESET : in STD_LOGIC;
           PS2_CLK : in  STD_LOGIC;
           PS2_DATA : in  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           DATA_READY : out  STD_LOGIC);
end PS2_Rx_Module;

architecture Behavioral of PS2_Rx_Module is
	type state is (idle, busy, dataCheck, dataReady);
	
	signal currentState, nextState : state;
	signal dataReg: STD_LOGIC_VECTOR (10 downto 0) := "11111111111";
	signal bitCounter: STD_LOGIC_VECTOR (3 downto 0) := "0000";
	signal ps2ClockChangeReg: STD_LOGIC_VECTOR (1 downto 0) := "00";
	signal isPs2ClockFalingEdge: STD_LOGIC := '0';
	signal parityCheck: STD_LOGIC := '0';
	
begin

	-- Faling edge check + assign
	PS2_CLOCK_SYNCH : process(CLK) begin
		if rising_edge(CLK) then
			ps2ClockChangeReg(1) <= PS2_CLK; -- index 1 is current value
			ps2ClockChangeReg(0) <= ps2ClockChangeReg(1); -- index 0 is previous value
			isPs2ClockFalingEdge <= ps2ClockChangeReg(0) and (not ps2ClockChangeReg(1)); -- '1' -> '0' == falling edge
		end if;
	end process;
	
	-- Count recived bits (used for state identyfication)
	COUNTER_PROCESS : process(CLK) begin
		if rising_edge(CLK) then
			if RESET = '1' or currentState = idle then
				bitCounter <= X"0";
			elsif (isPs2ClockFalingEdge = '1') then --check if PS2_CLOCK == faling edge
				bitCounter <= bitCounter + 1;
			end if;
		end if;
	end process;
	
	
	-- Save bits by shifting register to right each itearion (PS2 send from least to most signifi...)
	BITS_RECEIVER : process(CLK) begin
		if rising_edge(CLK) then
			if RESET = '1' then
				dataReg <= "11111111111";
			elsif (isPs2ClockFalingEdge = '1') then --check if PS2_CLOCK == faling edge
				dataReg(9 downto 0) <= dataReg(10 downto 1);
				dataReg(10) <= PS2_DATA;
			end if;
		end if;	
	end process;
	
	-- check parity
	parityCheck <= not(dataReg(10) xor dataReg(8) xor dataReg(7) xor dataReg(6) xor dataReg(5) 
						xor dataReg(4) xor dataReg(3) xor dataReg(2) xor dataReg(1) xor dataReg(0));

	
	-- assign state
	STATE_SETUP : process(CLK) begin
		if rising_edge(CLK) then
			if reset = '1' then
				currentState <= idle;
			else
				currentState <= nextState; 
			end if;
		end if;
	end process;
		
	
	-- handle states change
	STATE_MACHINE : process(currentState, dataReg, parityCheck, ps2ClockChangeReg, bitCounter) begin
		nextState <= currentState;
		
		case currentState is
			-- recived first (start) bit
			when idle => 
				if dataReg(10) = '0' then
					nextState <= busy;
				end if;
			
			-- receiving data
			when busy =>
				if bitCounter = "1011" then
					nextState <= dataCheck;
				end if;
		
			-- set to dataReady if correct, idle otherwise
			when dataCheck =>
				if parityCheck = dataReg(9) and dataReg(0) = '0' and dataReg(10) = '1' then
					nextState <= dataReady;
				else 
					nextState <= idle;
				end if;
			
			when others => 
				nextState <= idle;
			
		end case;
	end process;
	
	DATA_READY <= '1' when currentState = dataReady else '0';
	DATA_OUT <= dataReg(8 downto 1);
	
end Behavioral;


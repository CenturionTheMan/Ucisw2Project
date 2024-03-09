library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PS2_Rx_Module is
    Port ( CLK : in  STD_LOGIC;
		   RESET : in STD_LOGIC;
           PS2_CLK : in  STD_LOGIC;
           PS2_DATA : in  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           READY : in  STD_LOGIC);
end PS2_Rx_Module;

architecture Behavioral of PS2_Rx_Module is
	type state is (idle, busy, dataCheck, ready);
	
	signal currentState, nextState : state;
	signal dataReg: STD_LOGIC_VECTOR (10 downto 0) := "11111111111";
	signal bitCounter: STD_LOGIC_VECTOR (4 downto 0) := "0000";
	signal fallingEdgeReg: STD_LOGIC_VECTOR (1 downto 0) := "00";
	signal parityCheck: STD_LOGIC := '0';
	
begin

	-- Faling edge check + assign
	FALLING_EDGE_PROCESS : process(CLK) begin
		if rising_edge(CLK) then
			-- do some magic with fallingEdgeReg to check if falling edge 
		end if;
		
	end process;
	
	-- Count recived bits (used for state identyfication)
	COUNTER_PROCESS : process(CLK, currentState. fallingEdgeReg, RESET) begin
		if rising_edge(CLK) then
			if state = ready or RESET = '1' then
				bitCounter <= X"0";
			elsif (1) then --check if PS2_CLOCK == faling edge
				bitCounter <= bitCounter + 1;
			end if;
		end if;
	end process;
	
	
	-- Save bits by shifting register to right each itearion (PS2 send from least to most signifi...)
	BITS_RECEIVER : process(CLK, PS2_DATA, dataReg) begin
		if rising_edge(CLK) then
			if RESET = '1' then
				dataReg <= "11111111111";
			elsif (1) then --check if PS2_CLOCK == faling edge
				dataReg(9 downto 0) <= dataReg(10 downto 1);
				dataReg(10) <= PS2_DATA;
			end if;
		end if;	
	end process;
	
	-- check parity
	parityCheck <= xor dataReg(9 downto 2);

	
	-- assign state
	STATE_SETUP : process(CLK, nextState) begin
		if rising_edge(CLK) then --should be done in falling??
			if reset = '1' then
				currentState <= idle;
			else
				currentState <= nextState; 
			end if;
		end if;
	end process;
		
	
	-- handle states change
	STATE_MACHINE : process(currentState, dataReg, parityCheck) begin
		nextState <= currentState;
		
		case currentState is
			-- recived first (start) bit
			when idle => 
				if dataReg(10) = '0' then
					nextState <= busy;
				end if;
			
			-- receiving data
			when busy =>
				if counterReg = "1011" then
					nextState <= dataCheck;
				end if;
		
			-- set to ready if correct, idle otherwise
			when dataCheck =>
				if parityCheck and (not counterReg(0)) and not counterReg(10) = '1' then
					nextState <= ready;
				else 
					nextState <= idle;
				end if;
			
			when others =>
				currentState <= idle;
		end case;
	end process;
	
	READY <= '1' when currentState = ready else '0';
	DATA_OUT <= dataReg;
	
end Behavioral;


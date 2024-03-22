library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PS2_FILTER is
    Port ( DATA_IN : in  STD_LOGIC_VECTOR (7 downto 0);
			  DATA_READY : in  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           F0 : out  STD_LOGIC;
			  DATA_READY_OUT : out STD_LOGIC
			  );
end PS2_FILTER;

architecture Behavioral of PS2_FILTER is

	signal prevData: STD_LOGIC_VECTOR (7 downto 0) := "11111111111";

begin
	
	TMP : process(DATA_READY) begin
		if DATA_READY = '1' then
			if DATA_IN = not X"F0" then
				DATA_OUT <= DATA_IN;
			end if;
				prevData <= DATA_IN;
		end if;
	end process;

DATA_READY_OUT <= DATA_READY;
F0 <= '1' when DATA_READY and prevData = X"F0" else '0';

end Behavioral;


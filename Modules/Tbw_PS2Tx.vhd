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

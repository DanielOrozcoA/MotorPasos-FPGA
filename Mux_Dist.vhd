library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_unsigned.all;

entity Mux_Dist is
	port(
	I1 : in std_logic;
	I2 : in std_logic;
	I3 : in std_logic;
	I4 : in std_logic;
	RST : in std_logic;
	P_R : in std_logic;
	START: in std_logic;
	STOP: in std_logic;
	H_U: out std_logic;
	LED_STATE: out std_logic_vector (3 downto 0);
	F : out std_logic_vector (3 downto 0)
	);
end Mux_Dist;

architecture simple of Mux_Dist is		

signal cta_n_A, cta_p_A: std_logic:='0';
signal cta_n_B, cta_p_B: std_logic:='0';
signal cta_n_C, cta_p_C: std_logic:='0';
signal cta_n_D, cta_p_D: std_logic:='0';
signal start_boton: std_logic:='0';
--signal start_boton2: std_logic:='0';
--signal reset: std_logic:= '0';

--signal stop_boton: std_logic:='0';

begin
	cta_p_A <= cta_n_A;
	cta_p_B <= cta_n_B;
	cta_p_C <= cta_n_C;
	cta_p_D <= cta_n_D;
	H_U <= start_boton;
	
	mux: process (cta_p_A, cta_p_B, cta_p_C, cta_p_D) is
	begin
		if(cta_p_A = '0' and cta_p_B = '0' and cta_p_C = '0' and cta_p_D = '0') then
			F <= "0000";
			LED_STATE <= not "0000";
		elsif(cta_p_A = '1' and cta_p_B = '0' and cta_p_C = '0' and cta_p_D = '0') then
			F <= "0001";
			LED_STATE <= not "0001";
		elsif(cta_p_A = '0' and cta_p_B = '1' and cta_p_C = '0' and cta_p_D = '0') then
			F <= "0010";
			LED_STATE <= not "0010";
		elsif(cta_p_A = '0' and cta_p_B = '0' and cta_p_C = '1' and cta_p_D = '0') then
			F <= "0100";
			LED_STATE <= not "0100";
		elsif(cta_p_A = '0' and cta_p_B = '0' and cta_p_C = '0' and cta_p_D = '1') then
			F <= "1000";
			LED_STATE <= not "1000";
		else
			F <= "0000";
			LED_STATE <= not "0000";
		end if;
	end process mux;

	cont1: process (cta_p_A, I1) is
	begin
		if (I1'event and I1 = '0') then
			if(cta_p_A = '0') then
				cta_n_A <= '1';
			elsif(cta_p_A = '1') then
				cta_n_A <= '0';
			else
				cta_n_A <= '0';
			end if;
		end if;
	end process cont1;

	cont2: process (cta_p_B, I2) is
	begin
		if (I2'event and I2 = '0') then
			if(cta_p_B = '0') then
				cta_n_B <= '1';
			elsif(cta_p_B = '1') then
				cta_n_B <= '0';
			else
				cta_n_B <= '0';
			end if;
		end if;
	end process cont2;

	cont3: process (cta_p_C, I3) is
	begin
		if (I3'event and I3 = '0') then
			if(cta_p_C = '0') then
				cta_n_C <= '1';
			elsif(cta_p_C = '1') then
				cta_n_C <= '0';
			else
				cta_n_C <= '0';
			end if;
		end if;
	end process cont3;

	cont4: process (cta_p_D, I4) is
	begin
		if (I4'event and I4 = '0') then
			if(cta_p_D = '0') then
				cta_n_D <= '1';
			elsif(cta_p_D = '1') then
				cta_n_D <= '0';
			else
				cta_n_D <= '0';
			end if;
		end if;
	end process cont4;

	boton_start: process (START, STOP, P_R, start_boton) is
	begin
		if(START'event and START = '0') then
			if(start_boton <= '0') then
				start_boton <= '1';
			elsif(start_boton <= '1') then
				start_boton <= '1';
			else
				start_boton <= '0';
				--H_U <= start_boton;
			end if;
		end if;
		
		--if(STOP'event and STOP = '0') then
		if(STOP = '0') then
			if(start_boton = '0') then
				start_boton <= '0';
			elsif(start_boton = '1') then
				start_boton <= '0';
			else
				start_boton <= '0';
			end if;
		end if;

		if(P_R = '1') then
			if(start_boton = '0') then
				start_boton <= '0';
			elsif(start_boton = '1') then
				start_boton <= '0';
			else
				start_boton <= '0';
			end if;
		end if;

--		if(P_R = '1') then
--			if(start_boton2 = '0') then
--				start_boton2 <= '0';
--			elsif(start_boton2 = '1') then
--				start_boton2 <= '0';
--			else
--				start_boton2 <= '0';
--			end if;
--		end if;
		
		
	end process boton_start;


end architecture simple;
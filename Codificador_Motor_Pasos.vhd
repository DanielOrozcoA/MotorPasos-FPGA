library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_unsigned.all;

entity Codificador_Motor_Pasos is
	port(
	I : in std_logic;
	DH : in std_logic;
	H: in std_logic;
	M : in std_logic_vector (1 downto 0);
	F : out std_logic_vector (3 downto 0);
	PH : out std_logic
	);
end Codificador_Motor_Pasos;

architecture simple of Codificador_Motor_Pasos is		

begin

	mux: process (M, I, DH, H) is
	begin
		if(I = '0' and DH = '0' and H = '1') then
		--if(I = '0' and DH = '0' and H = '1') then
		--if(I = '0') then
		case M is
--			when "00" => F <= "0001";
--						PH <= '0';
--			when "01" => F <= "0010";
--						PH <= '0';
--			when "10" => F <= "0100";
--						PH <= '0';
--			when "11" => F <= "1000";
--						PH <= '1';
--			when others => F <= "0000";
--			PH <= '0';
			when "00" => F <= "1001";
						PH <= '0';
			when "01" => F <= "0011";
						PH <= '0';
			when "10" => F <= "0110";
						PH <= '0';
			when "11" => F <= "1100";
						PH <= '1';
			when others => F <= "0000";
						PH <= '0';
		end case;
		--else
		elsif(I = '1' and DH = '0' and H = '0') then
		--elsif(I = '1' and DH = '0' and H = '1') then
--			F <= "0000";
--			PH <= '0';
		case M is
--			when "00" => F <= "1000";
--						PH <= '0';
--			when "01" => F <= "0100";
--						PH <= '0';
--			when "10" => F <= "0010";
--						PH <= '0';
--			when "11" => F <= "0001";
--						PH <= '1';
--			when others => F <= "0000";
--			PH <= '0';


--			when "00" => F <= "1001";
--						PH <= '0';
--			when "01" => F <= "0011";
--						PH <= '0';
--			when "10" => F <= "0110";
--						PH <= '0';
--			when "11" => F <= "1100";
--						PH <= '1';
--			when others => F <= "0000";
--						PH <= '0';



			when "00" => F <= "1100";
						PH <= '0';
			when "01" => F <= "0110";
						PH <= '0';
			when "10" => F <= "0011";
						PH <= '0';
			when "11" => F <= "1001";
						PH <= '1';
			when others => F <= "0000";
						PH <= '0';
		end case;
		else
			F <= "0000";
			PH <= '0';
		end if;
	end process mux;


end architecture simple;
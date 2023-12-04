library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_unsigned.all;

entity R_Contador_Pasos_9cm is
	
	generic(
--	K: integer:=2000;
--	N: integer:=11
	K: integer:=50000000;
	N: integer:=26
	);
	
	port(
	CLK : in std_logic;
	RST : in std_logic;
	H : in std_logic;
	--LEDS : out std_logic_vector(N-1 downto 0);
	PH : out std_logic
	);
end R_Contador_Pasos_9cm;

architecture simple of R_Contador_Pasos_9cm is				 
signal Qp,Qn : std_logic_vector(N-1 downto 0):=(others =>'0');
signal pls : std_logic :='0';
signal PLSconH: std_logic_vector(1 downto 0):=(others =>'0');

begin					
	--LEDS <= not Qp;
	PLSconH <= pls & H;
	
	Mux: process (PLSconH, Qp) is
	begin		
		case PLSconH is
			when "01" => Qn <= Qp+1;
			--when "11" => Qn <= (others=>'0');
			when "11" => Qn <= Qp;
			when others => Qn <= Qp;
		end case;
	end process Mux;
	
	Comparador: process (Qp) is
	begin
		if Qp = K then
			pls <= '1';
			PH <= '1';
		else pls <= '0';
			PH <= '0';
		end if;
	end process Comparador;
	
	Combinacional: process (CLK, RST) is
	begin
		if RST = '1' then
			Qp <= (others => '0');
		elsif CLK'event and CLK = '0' then
			Qp <= Qn;
		end if;
	end process Combinacional;


end architecture simple;
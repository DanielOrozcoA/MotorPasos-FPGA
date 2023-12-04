library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_unsigned.all;

entity Mux_Speed is
	port(
	CLK1 : in std_logic;
	CLK2 : in std_logic;
	SW   : in std_logic;
	BTX : out std_logic
	);
end Mux_Speed;

architecture simple of Mux_Speed is				 

signal FE1, FE2	: std_logic :='0';

begin
	mux: process (SW, FE1, FE2) is
	begin
		case SW is
			when '0' => BTX <= FE1;
			when '1' => BTX <= FE2;
			when others => BTX <= '0';
		end case;
	end process mux;
	
	on1: process (CLK1, FE1)
	begin
		if(CLK1 = '1') then
			FE1 <= '1';
		else
			FE1 <= '0';
		end if;
	end process on1;
	
	on2: process (CLK2, FE2)
	begin
		if(CLK2 = '1') then
			FE2 <= '1';
		else
			FE2 <= '0';
		end if;
	end process on2;
	
end architecture simple;
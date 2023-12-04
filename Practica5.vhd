library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_unsigned.all;

entity Practica5 is
	
	generic(
    K: integer:=99999999;
	N: integer:=27
	);
	
	port(
	CLOCK: in std_logic;
	RESET: in std_logic;
	START: in std_logic;
	STOP: in std_logic;
	B1: in std_logic; -- 3 cm
	B2: in std_logic; -- 5 cm
	B3: in std_logic; -- 7 cm
	B4: in std_logic; -- 9 cm
	SWITCH_SPEED: in std_logic;
	LEDS_MODO: out std_logic_vector(3 downto 0);
	MOTOR_OUT: out std_logic_vector(3 downto 0)
	
	
--	CLK : in std_logic;
--	RST : in std_logic;
--	H : in std_logic;
--	LEDS : out std_logic_vector(3 downto 0)

	);
end Practica5;

architecture simple of Practica5 is				 
--signal p_H: std_logic;
signal p_BT1: std_logic; --	SEÑAL DE SALIDA - BASE DE TIEMPO 1
signal p_BT2: std_logic; -- SEÑAL DE SALIDA - BASE DE TIEMPO 2
--signal p_P_R: std_logic;
signal p_H_U: std_logic; -- SEÑAL DE SALIDA - HABILITADOR UNIVERSAL - PARA HABILITAR BASES DE TIEMPO 1 Y 2
signal p_F: std_logic_vector(3 downto 0); -- HABILITADOR PARA DECIDIR DISTANCIA
signal p_BTX: std_logic; -- SEÑAL DE SALIDA - BASE DE TIEMPO MULTIPLEXADA
signal p_LEDS_1: std_logic_vector(1 downto 0); -- SEÑAL DE SALIDA - CUENTA DE NUMERO DE PASO
signal p_PH: std_logic; -- SEÑAL DE SALIDA - PULSO PARA INDICAR UN PASO COMPLETO
signal p_PH_1_3CM: std_logic; -- SEÑAL DE SALIDA - PULSO PARA INDICAR CUENTA TERMINADA DE 3 CM
signal p_PH_1_5CM: std_logic; -- SEÑAL DE SALIDA - PULSO PARA INDICAR CUENTA TERMINADA DE 5 CM
signal p_PH_1_7CM: std_logic; -- SEÑAL DE SALIDA - PULSO PARA INDICAR CUENTA TERMINADA DE 7 CM
signal p_PH_1_9CM: std_logic; -- SEÑAL DE SALIDA - PULSO PARA INDICAR CUENTA TERMINADA DE 9 CM
signal p_PH_1_XCM: std_logic; -- SEÑAL DE SALIDA - HABILITADOR PARA BASE DE TIEMPO FINAL
signal p_BdT: std_logic; -- SEÑAL DE SALIDA - FINAL DE BASE DE TIEMPO FINAL - HABILITADOR PARA REVERSA
signal p_R_PH_1_3CM: std_logic; -- SEÑAL DE SALIDA - REVERSA - PULSO PARA INDICAR CUENTA TERMINADA DE 3 CM
signal p_R_PH_1_5CM: std_logic; -- SEÑAL DE SALIDA - REVERSA - PULSO PARA INDICAR CUENTA TERMINADA DE 5 CM
signal p_R_PH_1_7CM: std_logic; -- SEÑAL DE SALIDA - REVERSA - PULSO PARA INDICAR CUENTA TERMINADA DE 7 CM
signal p_R_PH_1_9CM: std_logic; -- SEÑAL DE SALIDA - REVERSA - PULSO PARA INDICAR CUENTA TERMINADA DE 9 CM
signal p_R_PH_1_XCM: std_logic; -- SEÑAL DE SALIDA - PULSO PARA INDICAR CUENTA TERMINADA EN REVERSA Y REINICIAR SISTEMA

--signal cuenta: std_logic_vector(3 downto 0);

begin
	--U1 : entity work.P_BdT generic map(K,N) port map (CLK, RST,H,pulso);
	--U2 : entity work.P_Contador port map(pulso,RST,H,LEDS);
	p_PH_1_XCM <= p_PH_1_3CM or p_PH_1_5CM or p_PH_1_7CM or p_PH_1_9CM;
	p_R_PH_1_XCM <= p_R_PH_1_3CM or p_R_PH_1_5CM or p_R_PH_1_7CM or p_R_PH_1_9CM;
	
	U1: entity work.Mux_Dist port map(B1, B2, B3, B4, RESET, p_R_PH_1_XCM, START, STOP, p_H_U, LEDS_MODO, p_F); -- SELECCIÓN DE MODO
	U2: entity work.BdT_1 generic map(500000,23) port map (CLOCK, p_R_PH_1_XCM, p_H_U, p_BT1); -- BASE DE TIEMPO 1
	U3: entity work.BdT_2 generic map(100000,21) port map (CLOCK, p_R_PH_1_XCM, p_H_U, p_BT2); -- BASE DE TIEMPO 2
	U4: entity work.Mux_Speed port map(p_BT1, p_BT2, SWITCH_SPEED, p_BTX); -- MULTIPLEXOR BASE DE TIEMPO
	U5: entity work.Contador_Num_Paso generic map(3,2) port map (p_BTX, p_R_PH_1_XCM, p_H_U, p_LEDS_1); -- CONTADOR NUMERO DE PASOS
	U6: entity work.Codificador_Motor_Pasos	port map(p_PH_1_XCM, p_R_PH_1_XCM, p_H_U,p_LEDS_1, MOTOR_OUT, p_PH); -- CODIFICADOR MOTOR A PASOS
	U7: entity work.Contador_Pasos_3cm generic map (500,9) port map(p_PH, p_R_PH_1_XCM, p_F(0), p_PH_1_3CM); -- CONTADOR DE PASOS - 3 CM
	U8: entity work.Contador_Pasos_5cm generic map (1000,10) port map(p_PH, p_R_PH_1_XCM, p_F(1), p_PH_1_5CM); -- CONTADOR DE PASOS - 5 CM
	U9: entity work.Contador_Pasos_7cm generic map (1500,11) port map(p_PH, p_R_PH_1_XCM, p_F(2), p_PH_1_7CM); -- CONTADOR DE PASOS - 7 CM
	U10: entity work.Contador_Pasos_9cm generic map (2000,11) port map(p_PH, p_R_PH_1_XCM, p_F(3), p_PH_1_9CM); -- CONTADOR DE PASOS - 9 CM
	U11: entity work.BdT_End generic map (99999999,27) port map(CLOCK, p_R_PH_1_XCM, p_PH_1_XCM, p_BdT); -- BASE DE TIEMPO FINAL - 2 SEG
	U12: entity work.R_Contador_Pasos_3cm generic map (500,9) port map(p_PH, p_R_PH_1_XCM, p_F(0), p_R_PH_1_3CM); -- CONTADOR DE PASOS - 3 CM
	U13: entity work.R_Contador_Pasos_5cm generic map (1000,10) port map(p_PH, p_R_PH_1_XCM, p_F(1), p_R_PH_1_5CM); -- CONTADOR DE PASOS - 5 CM
	U14: entity work.R_Contador_Pasos_7cm generic map (1500,11) port map(p_PH, p_R_PH_1_XCM, p_F(2), p_R_PH_1_7CM); -- CONTADOR DE PASOS - 7 CM
	U15: entity work.R_Contador_Pasos_9cm generic map (2000,11) port map(p_PH, p_R_PH_1_XCM, p_F(3), p_R_PH_1_9CM); -- CONTADOR DE PASOS - 9 CM

end architecture simple;
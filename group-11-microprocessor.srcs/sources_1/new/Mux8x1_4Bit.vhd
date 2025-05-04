----------------------------------------------------------------------------------
-- Company: CSE_UOM
-- Engineer: Sheneth Fernando
-- Create Date: 05/04/2025 09:22:30 PM
-- Module Name: Mux8x1_4Bit - Behavioral

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mux8x1_4Bit is
    Port ( D0 : in STD_LOGIC_VECTOR (3 downto 0);
           D1 : in STD_LOGIC_VECTOR (3 downto 0);
           D2 : in STD_LOGIC_VECTOR (3 downto 0);
           D3 : in STD_LOGIC_VECTOR (3 downto 0);
           D4 : in STD_LOGIC_VECTOR (3 downto 0);
           D5 : in STD_LOGIC_VECTOR (3 downto 0);
           D6 : in STD_LOGIC_VECTOR (3 downto 0);
           D7 : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC_VECTOR (2 downto 0);
           en : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end Mux8x1_4Bit;

architecture Behavioral of Mux8x1_4Bit is

type data_array is array(0 to 7) of STD_LOGIC_VECTOR(3 downto 0);
signal mux_input : data_array;
signal selected_input : STD_LOGIC_VECTOR(3 downto 0);

begin
    -- Pack inputs into array
    mux_input(0) <= D0;
    mux_input(1) <= D1;
    mux_input(2) <= D2;
    mux_input(3) <= D3;
    mux_input(4) <= D4;
    mux_input(5) <= D5;
    mux_input(6) <= D6;
    mux_input(7) <= D7;

    selected_input <= mux_input(to_integer(unsigned(sel)));
    
    --With Enable Signal, Final Output
    Y <= selected_input and (en & en & en & en);

    
end Behavioral;

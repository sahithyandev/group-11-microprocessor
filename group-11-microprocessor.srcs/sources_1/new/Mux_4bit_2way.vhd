----------------------------------------------------------------------------------
-- Company: CSE_UOM
-- Engineer: Sheneth Fernando
-- Create Date: 05/04/2025 07:02:00 PM
-- Module Name: mux2x1_4Bit - Behavioral

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux_4bit_2way is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           En: in STD_LOGIC;
           sel : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end Mux_4bit_2way;

architecture Behavioral of Mux_4bit_2way is

signal not_sel : STD_LOGIC;
signal A_out, B_out : STD_LOGIC_VECTOR(3 downto 0);
signal mux_out : STD_LOGIC_VECTOR(3 downto 0);

begin
--Inverse of sel signal
not_sel <= not sel;

 A_out(0) <= A(0) AND not_sel;
 A_out(1) <= A(1) AND not_sel;
 A_out(2) <= A(2) AND not_sel;
 A_out(3) <= A(3) AND not_sel;

 B_out(0) <= B(0) AND sel;
 B_out(1) <= B(1) AND sel;
 B_out(2) <= B(2) AND sel;
 B_out(3) <= B(3) AND sel;

 --Output of the Multiplexer without considering Enable 
 mux_out(0) <= A_out(0) or B_out(0);
 mux_out(1) <= A_out(1) or B_out(1);
 mux_out(2) <= A_out(2) or B_out(2);
 mux_out(3) <= A_out(3) or B_out(3);
 
 --Final Output with Enable Signal
 Y(0) <= mux_out(0) and en;
 Y(1) <= mux_out(1) and en;
 Y(2) <= mux_out(2) and en;
 Y(3) <= mux_out(3) and en;
 
end Behavioral;

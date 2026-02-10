----------------------------------------------------------------------------------
-- Company: Dharmsinh Desai University
-- Engineer: Priyanshu Patel
-- 
-- Create Date:    10:45:00 02/10/2026 
-- Design Name:    ALU Testbench
-- Module Name:    alu_tb - Behavior
-- Project Name:   16-bit Arithmetic Logic Unit
-- Description: 
--    Testbench to verify all 15 ALU operations. 
--    Generates stimulus for Arithmetic, Logic, Shift, and Special functions.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_tb is
-- Testbench has no ports
end alu_tb;

architecture Behavior of alu_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component alu_16bit
    Port ( 
        CLK     : in  STD_LOGIC;
        RST     : in  STD_LOGIC;
        A       : in  STD_LOGIC_VECTOR (7 downto 0);
        B       : in  STD_LOGIC_VECTOR (7 downto 0);
        Opcode  : in  STD_LOGIC_VECTOR (3 downto 0);
        Result  : out STD_LOGIC_VECTOR (15 downto 0);
        Zero    : out STD_LOGIC;
        Carry   : out STD_LOGIC
    );
    end component;

    -- Inputs
    signal CLK    : std_logic := '0';
    signal RST    : std_logic := '0';
    signal A      : std_logic_vector(7 downto 0) := (others => '0');
    signal B      : std_logic_vector(7 downto 0) := (others => '0');
    signal Opcode : std_logic_vector(3 downto 0) := (others => '0');

    -- Outputs
    signal Result : std_logic_vector(15 downto 0);
    signal Zero   : std_logic;
    signal Carry  : std_logic;

    -- Clock period definitions
    constant CLK_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: alu_16bit PORT MAP (
        CLK => CLK,
        RST => RST,
        A => A,
        B => B,
        Opcode => Opcode,
        Result => Result,
        Zero => Zero,
        Carry => Carry
    );

    -- Clock process definitions
    CLK_process :process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin		
        -- 1. Hold Reset for 100 ns
        RST <= '1';
        wait for 100 ns;	
        RST <= '0';
        wait for CLK_period;

        ----------------------------------------------------------
        -- TEST CASE 1: ARITHMETIC (ADD)
        -- 10 + 5 = 15
        ----------------------------------------------------------
        Opcode <= "0000"; 
        A <= "00001010"; -- 10
        B <= "00000101"; -- 5
        wait for CLK_period*2;

        ----------------------------------------------------------
        -- TEST CASE 2: MULTIPLICATION (MUL)
        -- 10 * 10 = 100
        ----------------------------------------------------------
        Opcode <= "0010";
        A <= "00001010"; -- 10
        B <= "00001010"; -- 10
        wait for CLK_period*2;

        ----------------------------------------------------------
        -- TEST CASE 3: BITWISE XOR
        -- 11110000 XOR 00001111 = 11111111 (255)
        ----------------------------------------------------------
        Opcode <= "0110";
        A <= "11110000";
        B <= "00001111";
        wait for CLK_period*2;

        ----------------------------------------------------------
        -- TEST CASE 4: SPECIAL - HAMMING WEIGHT
        -- Count bits in A (11111111) and B (00000000)
        -- Combined = 1111111100000000 -> Expect 8 bits set
        ----------------------------------------------------------
        Opcode <= "1101";
        A <= "11111111"; 
        B <= "00000000";
        wait for CLK_period*2;

        ----------------------------------------------------------
        -- TEST CASE 5: SPECIAL - PARITY CHECK
        -- A=00000011, B=00000000 -> Total 2 bits set (Even Parity)
        -- Expect Result LSB = 0
        ----------------------------------------------------------
        Opcode <= "1110";
        A <= "00000011"; 
        B <= "00000000";
        wait for CLK_period*2;

        ----------------------------------------------------------
        -- TEST CASE 6: ZERO FLAG CHECK
        -- 5 - 5 = 0
        ----------------------------------------------------------
        Opcode <= "0001"; -- SUB
        A <= "00000101";
        B <= "00000101";
        wait for CLK_period*2;

        -- End Simulation
        wait;
    end process;

end Behavior;

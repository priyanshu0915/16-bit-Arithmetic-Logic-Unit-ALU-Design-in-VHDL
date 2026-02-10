----------------------------------------------------------------------------------
-- Company: Dharmsinh Desai University
-- Engineer: Priyanshu Patel
-- 
-- Create Date:    10:25:00 02/10/2026 
-- Design Name:    16-bit ALU (Behavioral Model)
-- Module Name:    alu_behavioral - Behavioral 
-- Project Name:   16-bit Arithmetic Logic Unit
-- Target Devices: FPGA (Xilinx Artix-7 / Spartan-6)
-- Tool versions:  Vivado 2023.2
-- Description: 
--    A behavioral implementation of a 16-bit ALU processing two 8-bit inputs.
--    Supports 15 operations including Arithmetic, Logic, Shift, and
--    Advanced Bit Manipulation (Hamming Weight, Parity).
--
-- Dependencies: IEEE.NUMERIC_STD
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_16bit is
    Port ( 
        CLK     : in  STD_LOGIC;                      -- Clock for synchronous operation
        RST     : in  STD_LOGIC;                      -- Active High Reset
        A       : in  STD_LOGIC_VECTOR (7 downto 0);  -- Input A (8-bit)
        B       : in  STD_LOGIC_VECTOR (7 downto 0);  -- Input B (8-bit)
        Opcode  : in  STD_LOGIC_VECTOR (3 downto 0);  -- 4-bit Operation Selector
        Result  : out STD_LOGIC_VECTOR (15 downto 0); -- 16-bit Output
        Zero    : out STD_LOGIC;                      -- Zero Flag
        Carry   : out STD_LOGIC                       -- Carry/Overflow Flag
    );
end alu_16bit;

architecture Behavioral of alu_16bit is

begin

    -- Main Behavioral Process
    process(CLK)
        -- Variables for intermediate calculations
        variable v_A, v_B     : unsigned(7 downto 0);
        variable v_Result     : unsigned(15 downto 0);
        variable v_Combined   : unsigned(15 downto 0); -- For bitwise ops on full 16-bit width
        variable v_Hamming    : integer range 0 to 16;
        variable v_Parity     : std_logic;
        variable i            : integer;
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                Result <= (others => '0');
                Zero   <= '0';
                Carry  <= '0';
            else
                -- Type Casting inputs to Unsigned for arithmetic
                v_A := unsigned(A);
                v_B := unsigned(B);
                
                -- Default Reset of Variables
                v_Result := (others => '0');
                v_Combined := v_A & v_B; -- Combine A and B for 16-bit bitwise ops
                v_Hamming := 0;
                v_Parity := '0';

                -- Behavioral Case Statement (The Core Logic)
                case Opcode is
                    
                    -- ARITHMETIC OPERATIONS
                    when "0000" => -- ADD (A + B)
                        v_Result := resize(v_A, 16) + resize(v_B, 16);
                        
                    when "0001" => -- SUB (A - B)
                        -- Check for underflow or handle as signed in future versions
                        if v_A >= v_B then
                            v_Result := resize(v_A - v_B, 16);
                        else
                            v_Result := resize(v_B - v_A, 16); -- Absolute difference
                        end if;
                        
                    when "0010" => -- MUL (A * B)
                        v_Result := v_A * v_B; -- 8bit * 8bit = 16bit Result
                        
                    when "0011" => -- DIV (A / B)
                        if v_B /= 0 then
                            v_Result := resize(v_A / v_B, 16);
                        else
                            v_Result := (others => '1'); -- Error/Max Value on Divide by Zero
                        end if;

                    -- LOGICAL OPERATIONS (Bitwise)
                    when "0100" => -- AND
                        v_Result := resize(v_A and v_B, 16);
                        
                    when "0101" => -- OR
                        v_Result := resize(v_A or v_B, 16);
                        
                    when "0110" => -- XOR
                        v_Result := resize(v_A xor v_B, 16);
                        
                    when "0111" => -- NAND
                        v_Result := resize(not(v_A and v_B), 16);
                        
                    when "1000" => -- NOR
                        v_Result := resize(not(v_A or v_B), 16);

                    -- SHIFT OPERATIONS
                    when "1001" => -- Logical Shift Left (A << 1)
                        v_Result := resize(v_A sll 1, 16);
                        
                    when "1010" => -- Logical Shift Right (A >> 1)
                        v_Result := resize(v_A srl 1, 16);
                        
                    when "1011" => -- Rotate Left (Combined A&B)
                        v_Result := v_Combined rol 1;
                        
                    when "1100" => -- Rotate Right (Combined A&B)
                        v_Result := v_Combined ror 1;

                    -- ADVANCED OPERATIONS (DSP/Crypto)
                    when "1101" => -- Hamming Weight (Count set bits in A&B)
                        v_Hamming := 0;
                        for i in 0 to 15 loop
                            if v_Combined(i) = '1' then
                                v_Hamming := v_Hamming + 1;
                            end if;
                        end loop;
                        v_Result := to_unsigned(v_Hamming, 16);
                        
                    when "1110" => -- Parity Check (XOR reduction of A&B)
                        v_Parity := '0';
                        for i in 0 to 15 loop
                            v_Parity := v_Parity xor v_Combined(i);
                        end loop;
                        v_Result := (others => '0');
                        v_Result(0) := v_Parity;

                    when others => 
                        v_Result := (others => '0');
                end case;

                -- Output Assignments
                Result <= std_logic_vector(v_Result);
                
                -- Flag Logic
                if v_Result = 0 then
                    Zero <= '1';
                else
                    Zero <= '0';
                end if;
                
                -- Simple Carry Logic for ADD (checking 9th bit equivalent)
                if Opcode = "0000" and (resize(v_A, 16) + resize(v_B, 16) > 255) then
                    Carry <= '1';
                else
                    Carry <= '0';
                end if;
                
            end if;
        end if;
    end process;

end Behavioral;

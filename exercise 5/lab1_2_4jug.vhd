LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY lab1_2_4jug IS
	PORT(
	--each group of inputs correstponds to a different encoder, to different players
	--a or x for scissors
	--b or y for stone
	--c or z for paper
		t1,s1,p1: IN STD_LOGIC;--0A
		t2,s2,p2: IN STD_LOGIC;--0B
		t3,s3,p3: IN STD_LOGIC;--1A
		t4,s4,p4: IN STD_LOGIC;--1B
		SEL: IN STD_logic_vector(1 downto 0);

		z1,z2: OUT STD_LOGIC
	--the z would be theoutputs ofour game, z1=1 for ply1 winning, z2=1 for py 2 winning, and 1 1 for a draw
	);
END lab1_2_4jug;

ARCHITECTURE arch1 of lab1_2_4jug is

	--signal s0_1,s1_1,s0_2,s1_2: std_logic;
	signal s_1,s_2,s_3,s_4,x1,x2: std_logic_vector(1 downto 0);
begin 

process(t1,s1,p1,t2,s2,p2,t3,s3,p3,t4,s4,p4)
--encoder process, gives s1 and s2 vectores
-- we are giving our inputs a binary output of the encoder
	begin
	if t1 = '1' and s1='0' and p1='0'then
		s_1 <= "11";
	elsif s1 = '1' and t1='0' and p1='0'then 
		s_1 <= "10";
	elsif p1 = '1' and s1='0' and t1='0' then 
		s_1 <= "01";
	else 
		s_1 <= "00";
	end if;
	
	if t2= '1' and p2='0' and s2='0'then
		s_2 <= "11";
	elsif s2 = '1' and t2='0' and p2='0' then 
		s_2 <= "10";
	elsif p2 = '1' and t2='0' and s2='0' then 
		s_2 <= "01";
	else 
		s_2 <= "00";
	end if;

	if t3 = '1' and s3='0' and p3='0'then
		s_3 <= "11";
	elsif s3 = '1' and t3='0' and p3='0'then 
		s_3 <= "10";
	elsif p3 = '1' and s3='0' and t3='0' then 
		s_3 <= "01";
	else 
		s_3 <= "00";
	end if;

	if t4 = '1' and s4='0' and p4='0'then
		s_4 <= "11";
	elsif s4 = '1' and t4='0' and p4='0'then 
		s_4 <= "10";
	elsif p4 = '1' and s4='0' and t4='0' then 
		s_4 <= "01";
	else 
		s_4 <= "00";
	end if;
	
			
end process;
--we add this process to select the signal that we are using taking into account the Selection of participants
process (s_1,s_2,s_3,s_4)
begin 
case SEL is 
when "00" => 
x1<=s_1;
x2<=s_2;
when "01" => 
x1<=s_1;
x2<=s_4;
when "10" =>
x1<=s_3;
x2<=s_2;
when others =>
x1<=s_3;
x2<=s_4;
end case;
end process;

process (x1,x2)
	begin 
-- we preselect the values of the outputs so we only have to change when 1 
	z1<='0';
	z2<='0';
-- we use priority 
--case when no botton is pressed 
		if x1="00" or x2="00" then 
			z1<='0';
			z2<='0';
--both players select the same option, so tie 
		elsif x1=x2 then
			z1<='1';
			z2<='1';
--first player selects scissors
		elsif x1="11" then 
--second selects stone 
			if x2="10" then 
				z2<='1';
-- the only option left for py 2 is '01', paper
			else 
				z1<='1';
			end if;
-- the first py selects stone 
		elsif x1="10" then
-- py2 selects scissors 
			if x2="11" then 
				z1<='1';
--py2 selects paper 
			else
				z2<='1';
			end if;
--py1 selects paper 
		else
-- py2 selects scissors 
			if x2="11" then 
				z2<='1';
--py2 selects stone 
			else
				z1<='1';			
			
				
			end if;
		end if;
end process;
		
end arch1; 

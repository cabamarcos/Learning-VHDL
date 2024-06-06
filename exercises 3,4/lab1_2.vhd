LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY lab1_2 IS
	PORT(
	--each group of inputs correstponds to a different encoder, to different players
	--a or x for scissors
	--b or y for stone
	--c or z for paper
		a,b,c: IN STD_LOGIC;
		x,y,z: IN STD_LOGIC;
		z1,z2: OUT STD_LOGIC
	--the z would be theoutputs ofour game, z1=1 for ply1 winning, z2=1 for py 2 winning, and 1 1 for a draw
	);
END lab1_2;

ARCHITECTURE arch1 of lab1_2 is

	--signal s0_1,s1_1,s0_2,s1_2: std_logic;
	signal s1,s2: std_logic_vector(1 downto 0);
begin 

process(a,b,c,x,y,z)
--encoder process, gives s1 and s2 vectores
-- we are giving our inputs a binary output of the encoder
	begin
	if a = '1' and b='0' and c='0'then
		s1 <= "11";
	elsif b = '1' and a='0' and c='0'then 
		s1 <= "10";
	elsif c = '1' and b='0' and a='0' then 
		s1 <= "01";
	else 
		s1 <= "00";
	end if;
	
	if x= '1' and z='0' and y='0'then
		s2 <= "11";
	elsif y = '1' and x='0' and z='0' then 
		s2 <= "10";
	elsif z = '1' and x='0' and y='0' then 
		s2 <= "01";
	else 
		s2 <= "00";
	end if;	
			
end process;

process (s1,s2)
	begin 
-- we preselect the values of the outputs so we only have to change when 1 
	z1<='0';
	z2<='0';
-- we use priority 
--case when no botton is pressed 
		if s1="00" or s2="00" then 
			z1<='0';
			z2<='0';
--both players select the same option, so tie 
		elsif s1=s2 then
			z1<='1';
			z2<='1';
--first player selects scissors
		elsif s1="11" then 
--second selects stone 
			if s2="10" then 
				z2<='1';
-- the only option left for py 2 is '01', paper
			else 
				z1<='1';
			end if;
-- the first py selects stone 
		elsif s1="10" then
-- py2 selects scissors 
			if s2="11" then 
				z1<='1';
--py2 selects paper 
			else
				z2<='1';
			end if;
--py1 selects paper 
		else
-- py2 selects scissors 
			if s2="11" then 
				z2<='1';
--py2 selects stone 
			else
				z1<='1';			
			
				
			end if;
		end if;
end process;
		
end arch1; 

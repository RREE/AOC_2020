with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
 
procedure AoC_2020_03 is

   Input_Filename : constant string := "input_03.txt";
   Input_File     : File_Type;

   -- type Cell_Status_T is (Open, Tree);

   Map_Width_Modulo : constant := 31;
   Map_Height       : Natural := 0;
   type Map_Width is mod Map_Width_Modulo;
  
   --  package Map_Lines_Lists is new Ada.Containers.Vectors (Natural, Str32);
   --  use Map_Lines_Lists;

   --  Map_Lines : Map_Lines_Lists.Vector := Empty_Vector;

   Nr_Of_Trees : Natural := 0;
   Pos : Map_Width := 0;

begin
   Open (Input_File, In_File, Input_Filename);
   while not End_Of_File (Input_File) loop
      Read_Map:
      declare
         Line : constant String := Get_Line (Input_File);
      begin
	     if Line'Length /= Map_Width_Modulo then
		    raise Data_Error;
		 end if;
         Map_Height := @ + 1; -- count the number of lines, nor relevant for the solution
		 if Line (Pos+1) = '#' then
		    Nr_Of_Trees := @ + 1;
         end if;
		 Pos := @ + 3; -- modulo semantics, wraps around at 32
         -- Map_Lines.Append (Line);
      end Read_Map;
      Put_Line ("found" & Nr_Of_Trees'Image & " along the slope across" & 
                Map_Height'Image & " map lines.");
   end loop;
   
-- Build_And_Analyze_Map:
   -- declare
      -- type Height_Count is range 0 .. Map_Lines.Length
      -- subtype Map_Height is Height_Count range 1 .. Height_Count'Last;
      -- type Map_T is array (Map_Width, Map_Height) of Cell_Status_T;
      -- Map : Map_T;
	  -- L_Idx : Map_Height := 0;
	  -- W_Idx : Map_Width;
   -- begin
      -- for Line of Map_Lines loop
	     -- L_Idx := @ + 1;
         -- W_Idx := 0;
		 -- for C of Line loop
		    -- Map (W_Idx, L_Idx) := (if C = '.' then Open else Tree);
			-- W_Idx := @ + 1;
		 -- end loop;
      -- end loop;
      -- Put_Line ("found" & Valid_Passwords'Image & " valid passwords.");
   -- end Build_And_Analyze_Map;
   

exception
   when Name_Error =>
   Ada.Text_IO.Put_Line ("file not found: '" & Input_Filename & "'");
end AoC_2020_03;

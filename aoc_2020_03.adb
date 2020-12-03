pragma Ada_2020;

with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;

procedure AoC_2020_03 is

   Input_Filename : constant string := "input_03.txt";
   Input_File     : File_Type;

   Map_Width_Modulo : constant := 31;
   Map_Height       : Natural := 0;
   type Map_Width is mod Map_Width_Modulo;

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
         if Line (Natural(Pos)+1) = '#' then
            Nr_Of_Trees := @ + 1;
         end if;
         Pos := @ + 3; -- modulo semantics, wraps around at 32
      end Read_Map;
      Put_Line ("found" & Nr_Of_Trees'Image & " along the slope across" &
                  Map_Height'Image & " map lines.");
   end loop;


exception
when Name_Error =>
   Ada.Text_IO.Put_Line ("file not found: '" & Input_Filename & "'");
end AoC_2020_03;

pragma Ada_2020;
with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;

procedure Aoc_2020_03_2 is

   Input_Filename : constant string := "input_03.txt";
   Input_File     : File_Type;

   Map_Width_Modulo : constant := 31;
   Map_Height       : Natural  := 0;
   type Map_Width is mod Map_Width_Modulo;

   subtype Tree_Count is Long_Integer;
   type Slopes is range 1 .. 5;
   Trees : array (Slopes) of Tree_Count := (others => 0);
   Pos   : array (Slopes) of Map_Width  := (others => 0);
   Inc   : constant array (Slopes) of Map_Width := (1, 3, 5, 7, 1);
   Product : Tree_Count := 1;

begin
   Open (Input_File, In_File, Input_Filename);
   while not End_Of_File (Input_File) loop
      Read_Map:
      declare
         Line : constant String := Get_Line (Input_File);
      begin
         if Line'Length /= Map_Width_Modulo then raise Data_Error; end if;
         Map_Height := @ + 1;
         for S in Slopes'(1) .. 4 loop
            if Line (Natural(Pos(S)) + 1) = '#' then
               Trees (S) := @ + 1;
            end if;
            Pos(S) := @ + Inc(S); -- modulo semantics, wraps around at 31
         end loop;
         if Map_Height mod 2 = 1 then
            if Line (Natural(Pos(5))+1) = '#' then
               Trees(5) := @ + 1;
            end if;
            Pos(5) := @ + Inc(5); -- modulo semantics, wraps around at 31
         end if;
      end Read_Map;
   end loop;
   for S in Slopes loop
      Put_Line ("found" & Trees(S)'Image & " along slope" & S'Image);
   end loop;
   for T of Trees loop
      Product := @ * T;
   end loop;
   Put_Line ("product" & Product'Image);

exception
when Name_Error =>
   Ada.Text_IO.Put_Line ("file not found: '" & Input_Filename & "'");
end Aoc_2020_03_2;

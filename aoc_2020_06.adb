pragma Ada_2020;

with Ada.Text_IO;                 use Ada.Text_IO;

procedure AoC_2020_06 is

   Input_Filename : constant string := "input_06.txt";
   Input_File     : File_Type;

   Questions : array (Character range 'a' .. 'z') of Boolean;

   Count : Natural := 0;

begin
   Open (Input_File, In_File, Input_Filename);

   Questions := (others => False);

   Get_Groups:
   loop
      declare
         Line : constant String := Get_Line (Input_File);
      begin
         if Line'Length = 0 then
            -- answers within group
            for Q of Questions loop
               if Q then
                  Count := @ + 1;
               end if;
               Q := False;
            end loop;
         end if;
         --  collect attributes from current line
         for C of Line loop
            Questions(C) := True;
         end loop;

         if End_Of_File (Input_File) then
            -- answers within group
            for Q of Questions loop
               if Q then
                  Count := @ + 1;
               end if;
            end loop;
            exit Get_Groups;
         end if;
      end;
   end loop Get_Groups;
   Put_Line ("found" & Count'Image & " positive answers.");

exception
when Name_Error =>
   Ada.Text_IO.Put_Line ("file not found: '" & Input_Filename & "'");
end AoC_2020_06;

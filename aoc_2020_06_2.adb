pragma Ada_2020;

with Ada.Text_IO;                 use Ada.Text_IO;

procedure Aoc_2020_06_2 is

   Input_Filename : constant string := "input_06.txt";
   Input_File     : File_Type;

   type Answers_A is array (Character range 'a' .. 'z') of Boolean;

   Group_Answers : Answers_A;

   Count : Natural := 0;
   First_Person : Boolean;

begin
   Open (Input_File, In_File, Input_Filename);

   Group_Answers := (others => False);
   First_Person := True;

   Get_Groups:
   loop
      declare
         Line : constant String := Get_Line (Input_File);
         Person_Answers : Answers_A := (others => False);
      begin
         if Line'Length = 0 then
            -- answers within group
            for Q of Group_Answers loop
               if Q then
                  Count := @ + 1;
               end if;
               Q := False;
            end loop;
            First_Person := True;
         else
            --  collect answers from current line
            if First_Person then
               for C of Line loop
                  Group_Answers(C) := True;
               end loop;
               First_Person := False;
            else
               for C of Line loop
                  Person_Answers(C) := True;
               end loop;
               Group_Answers := @ and Person_Answers;
            end if;
         end if;

         if End_Of_File (Input_File) then
            -- answers within group
            for Q of Group_Answers loop
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
end Aoc_2020_06_2;

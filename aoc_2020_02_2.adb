with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;

procedure Aoc_2020_02_2 is


   Max_Pw_Length : constant := 900; -- maximum number of characters in a password

   subtype Char_Count is Integer range 0 .. Max_Pw_Length;

   Input_Filename : constant string := "input_02.txt";
   Input_File     : File_Type;

   Valid_Passwords : Natural := 0;

begin
   Open (Input_File, In_File, Input_Filename);
   while not End_Of_File (Input_File) loop
      Analyze:
      declare
         Line : constant String := Get_Line (Input_File);
         Min, Max : Char_Count;
         Last : Char_Count;
         Check_Char : Character;
      begin
         Get (Line, Min, Last);
         Get (Line(Last+2 .. Line'Last), Max, Last);
         Check_Char := Line (Last+2);

         Min := Min + Last + 4;
         Max := Max + Last + 4;
         if Min <= Line'Last and then
           Max <= Line'Last and then
           ((Check_Char = Line (Min) and then Check_Char /= Line (Max)) or else
              (Check_Char /= Line (Min) and then Check_Char = Line (Max)))
         then
            Valid_Passwords := Valid_Passwords + 1;
         end if;
         --  Ada.Text_IO.Put_Line ("min:" & Min'Image & ", max:" & Max'Image & ", c: " & Check_Char
         --                          & ", #val:"& Valid_Passwords'Image
         --                          & ", pw: " & Line (Last+5 .. Line'Last));

      end Analyze;

   end loop;

   Put_Line ("found" & Valid_Passwords'Image & " valid passwords.");

exception
   when Name_Error =>
   Ada.Text_Io.Put_Line ("file not found: '" & Input_Filename & "'");
end Aoc_2020_02_2;

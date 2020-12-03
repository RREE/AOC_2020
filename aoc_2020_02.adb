with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;

procedure AoC_2020_02 is

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
         Min, Max    : Char_Count;
         Last        : Char_Count;
         Check_Char  : Character;
         Check_Count : Char_Count;
      begin
         Get (Line, Min, Last);
         Get (Line(Last+2 .. Line'Last), Max, Last);
         Check_Char := Line (Last+2);

         --  count the occurences of the Check_Char within the password
         Check_Count := 0;
         for C of Line(Last+5 .. Line'Last) loop
            if C = Check_Char then
               Check_Count := @ + 1;
            end if;
         end loop;

         --  if Min <= Check_Count and then Check_Count <= Max then
		 if Check_Count in Min .. Max then
            Valid_Passwords := @ + 1;
         end if;

      end Analyze;

   end loop;

   Put_Line ("found" & Valid_Passwords'Image & " valid passwords.");

exception
   when Name_Error =>
   Ada.Text_IO.Put_Line ("file not found: '" & Input_Filename & "'");
end AoC_2020_02;

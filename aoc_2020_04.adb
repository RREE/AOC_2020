pragma Ada_2020;

with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Containers.Vectors;

procedure AoC_2020_04 is

   Input_Filename : constant string := "input_04.txt";
   Input_File     : File_Type;

   type PP_Attributes is (Birth_Year, Issue_Year, Expiration_Year, Height, 
                          Hair_Color, Eye_Color, Passport_Id, Country_Id);
   subtype Required_PP_Attributes is PP_Attributes range Birth_Year .. Passport_Id;
   subtype Optional_PP_Attributes is PP_Attributes range Country_Id .. Country_Id;
   
   subtype Abbr3 is String range (1 .. 3);
   Attr_Keys : constant array (PP_Attributes) of Abbr3 :=
     (Birth_Year  => "byr",
	  Issue_Year  => "iyr",
	  Expiration_Year => "eyr",
	  Height      => "hgt",
	  Hair_Color  => "hcl",
	  Eye_Color   => "ecl",
	  Passport_Id => "pid",
	  Country_Id  => "cid");
  
begin
   Open (Input_File, In_File, Input_Filename);
   while not End_Of_File (Input_File) loop
      Read_Passports:
      declare
         Line : constant String := Get_Line (Input_File);
      begin
         if Line'Length = 0 then
		    -- finish record of a passport
			null;
            
         end if;
         --  collect attributes
		 
      end Read_Passport;
      Put_Line ("found" & Passports.Length'Image & " passports.");
   end loop;


exception
when Name_Error =>
   Ada.Text_IO.Put_Line ("file not found: '" & Input_Filename & "'");
end AoC_2020_04;

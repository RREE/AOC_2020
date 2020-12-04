pragma Ada_2020;

with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Strings.Fixed;           use Ada.Strings.Fixed;
with Ada.Strings.Unbounded;       use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;

procedure Aoc_2020_04_2 is

   Input_Filename : constant string := "input_04.txt";
   Input_File     : File_Type;

   function "+" (Source : in Unbounded_String) return String renames To_String;
   function "+" (Source : in String) return Unbounded_String renames To_Unbounded_String;

   type All_PP_Attributes is (Birth_Year, Issue_Year, Expiration_Year, Height,
                          Hair_Color, Eye_Color, Passport_Id, Country_Id, None);
   subtype PP_Attributes is All_PP_Attributes range Birth_Year .. Country_Id;
   subtype Required_PP_Attributes is PP_Attributes range Birth_Year .. Passport_Id;
   subtype Optional_PP_Attributes is PP_Attributes range Country_Id .. Country_Id;

   subtype Abbrev is String (1 .. 3);
   Attr_Keys : constant array (PP_Attributes) of Abbrev :=
     (Birth_Year      => "byr",
      Issue_Year      => "iyr",
      Expiration_Year => "eyr",
      Height          => "hgt",
      Hair_Color      => "hcl",
      Eye_Color       => "ecl",
      Passport_Id     => "pid",
      Country_Id      => "cid");

   type Passport_T is array (PP_Attributes) of Unbounded_String;

   package Pp_Lists is new Ada.Containers.Vectors (Natural, Passport_T);
   use Pp_Lists;
   Passports : Pp_Lists.Vector := Empty_Vector;

   Valid_Passports : Natural := 0;
   Pp : Passport_T := (others => +"missing");


   function Attr_From_Abbrev (Str : Abbrev) return All_Pp_Attributes
   is
   begin
      for A in Pp_Attributes loop
         if Str = Attr_Keys(A) then
            return A;
         end if;
      end loop;
      return None;
   end Attr_From_Abbrev;

   function Year_Is_Valid (Str : Unbounded_String; Min, Max : Natural) return Boolean
   is
      Val : Natural;
   begin
      Val := Integer'Value (+Str);
      if Val in Min .. Max then
         return True;
      else
         return False;
      end if;
   exception
   when others =>
      return False;
   end Year_Is_Valid;

   function Height_Is_Valid (Str : String) return Boolean is
      Val  : Natural;
      Unit : String (1..2);
   begin
      Val  := Natural'Value (Str(1..Str'Last-2));
      Unit := Str (Str'Last-1 .. Str'Last);
      if Unit = "in" then
         if Val in 59 .. 76 then return True; else return False; end if;
      end if;
      if Unit = "cm" then
         if Val in 150 .. 193 then return True; else return False; end if;
      end if;
      return False;
   exception
   when others => return False;
   end Height_Is_Valid;

   function Hair_Color_Is_Valid (Str : String) return Boolean is
   begin
      if Str(1) /= '#' then return False; end if;
      if Str'Length /= 7 then return False; end if;
      for I in Natural'(2) .. 7 loop
         if Str(I) not in '0' .. '9' and then Str(I) not in 'a' .. 'f' then return False; end if;
      end loop;
      return True;
   end Hair_Color_Is_Valid;

   function Eye_Color_Is_Valid (Str : String) return Boolean is
   begin
      if Str = "amb" or else Str = "blu" or else Str = "brn" or else Str = "gry"
        or else Str = "grn" or else Str = "hzl" or else Str = "oth" then
         return True;
      else
         return False;
      end if;
   end Eye_Color_Is_Valid;

   function Passport_Id_Is_Valid (Str : String) return Boolean is
   begin
      if Str'Length /= 9 then return False; end if;
      for C of Str loop
         if C not in '0' .. '9' then return False; end if;
      end loop;
      return True;
   end Passport_Id_Is_Valid;

   function Passport_Is_Valid (P : Passport_T) return Boolean
   is
   begin
      for Attr in Required_Pp_Attributes loop
         if +P(Attr) = "missing" then
            return False;
         end if;
      end loop;
      if not Year_Is_Valid (P(Birth_Year), 1920, 2002) then return False; end if;
      if not Year_Is_Valid (P(Issue_Year), 2010, 2020) then return False; end if;
      if not Year_Is_Valid (P(Expiration_Year), 2020, 2030) then return False; end if;
      if not Height_Is_Valid (+P(Height)) then return False; end if;
      if not Hair_Color_Is_Valid (+P(Hair_Color)) then return False; end if;
      if not Eye_Color_Is_Valid (+P(Eye_Color)) then return False; end if;
      if not Passport_Id_Is_Valid (+P(Passport_Id)) then return False; end if;
      return True;
   end Passport_Is_Valid;

begin
   Open (Input_File, In_File, Input_Filename);

   Read_Passports:
   loop
      declare
         Line : constant String := Get_Line (Input_File);
         Old, Ptr : Natural := 1;
      begin
         if Line'Length = 0 then
            -- finish record of a passport
            if Passport_Is_Valid (Pp) then
               Valid_Passports := @ + 1;
            end if;
            Pp := (others => +"missing");
         end if;
         --  collect attributes from current line
         Attributes_Within_Line:
         loop
            Ptr := Index (Source => Line, Pattern => ":", From => Old);
            if Ptr = Old+3 then
               declare
                  A : constant All_Pp_Attributes := Attr_From_Abbrev (Line(Old..Ptr-1));
               begin
                  if A /= None then
                     Old := Ptr+1;
                     Ptr := Index (Line, " ", Old);
                     if Ptr = 0 then Ptr := Line'Last+1; end if;
                     Pp(A) := +Line(Old..Ptr-1);
                     Old := Ptr + 1;
                  end if;
               end;
            end if;
            exit Attributes_Within_Line when Old >= Line'Last;
         end loop Attributes_Within_Line;
         if End_Of_File (Input_File) then
            if Passport_Is_Valid (Pp) then
               Valid_Passports := @ + 1;
            end if;
            exit Read_Passports;
         end if;
      end;
   end loop Read_Passports;
   Put_Line ("found" & Valid_Passports'Image & " valid passports.");

exception
when Name_Error =>
   Ada.Text_IO.Put_Line ("file not found: '" & Input_Filename & "'");
end AoC_2020_04_2;

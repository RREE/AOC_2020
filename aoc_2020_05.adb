pragma Ada_2020;

with Ada.Text_IO;                 use Ada.Text_IO;
with Interfaces;                  use Interfaces;

procedure AoC_2020_05 is

   Input_Filename : constant string := "input_05.txt";
   Input_File     : File_Type;

   subtype Line_Index is Natural range 1 .. 10;
   subtype Rows_Index is Line_Index range 1 .. 7;
   subtype Seat_Index is Line_Index range 8 .. 10;

   subtype Seat_Id_T is Unsigned_32;
   subtype Row_T     is Unsigned_32 range 0 .. 255;
   subtype Col_T     is Unsigned_32 range 0 .. 15;
   Max_Seat_Id : Seat_Id_T := 0;

begin
   Open (Input_File, In_File, Input_Filename);
   while not End_Of_File (Input_File) loop
      declare
         Line : constant String := Get_Line (Input_File);
         Row  : Row_T      := 0;
         Col  : Col_T      := 0;
         Seat_Id : Seat_Id_T;
      begin
         if Line'Length /= 10 then raise Data_Error; end if;
         for I in Rows_Index loop
            if Line(I) /= 'B' and then Line(I) /= 'F' then raise Data_Error; end if;
            if Line(I) = 'B' then Row := @ or 1; end if;
            Row := @ * 2;
         end loop;
         Row := @ / 2;
         for I in Seat_Index loop
            if Line(I) /= 'L' and then Line(I) /= 'R' then raise Data_Error; end if;
            if Line(I) = 'R' then Col := @ or 1; end if;
            Col := @ * 2;
         end loop;
         Col := Col / 2;
         Seat_Id := Row * 8 + Col;
         Max_Seat_Id := Seat_Id_T'Max (Max_Seat_Id, Seat_Id);
      end;
   end loop;
   Put_Line ("max seat ID:" & Max_Seat_Id'Image);


exception
when Name_Error =>
   Ada.Text_IO.Put_Line ("file not found: '" & Input_Filename & "'");
end AoC_2020_05;

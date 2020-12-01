with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Containers.Vectors;

procedure AoC_2020_01 is

   Target_Sum : constant := 2020;

   Max_Expenses : constant := 1000; -- maximum number of entries in the Input list

   type Expense_Index is range 1 .. Max_Expenses;

   subtype Expense is Integer range 0 .. 2020;

   package Expense_Lists is new ada.containers.vectors (Expense_Index, Expense);
   use Expense_Lists;

   Input : Expense_Lists.Vector := Empty_Vector;


   procedure Get_Input
   is
      Input_Filename : constant string := "input_01.txt";
      Input_File     : File_Type;
      E : Expense;
   begin
      Open (Input_File, In_File, Input_Filename);
      while not End_Of_File (Input_File) loop
         Get (Input_File, E);
         Input.Append (E);
      end loop;
      Ada.Text_IO.Put_Line ("read " & Input.Length'Image & " entries from " & Input_Filename);
   exception
   when Name_Error =>
      Ada.Text_Io.Put_Line ("file not found: '" & Input_Filename & "'");
   end Get_Input;

begin
   Get_Input;

   Outer_Loop: for Outer_Index in Input.First_Index .. Input.Last_Index loop
      Inner_Loop: for Inner_Index in Outer_Index .. Input.Last_Index loop
         declare
            Outer : constant Expense := Input (Outer_Index);
            Inner : constant Expense := Input (Inner_Index);
            Product : Natural;
         begin
            if Outer + Inner = Target_Sum then
               -- FOUND!!
               Product := Outer * Inner;
               Ada.Text_IO.Put_Line
                 (Outer'Image & " +" & Inner'Image &
                    " = 2020," & Outer'Image & " *" & Inner'Image & " =" & Product'Image);
            end if;
         end;
      end loop Inner_Loop;
   end loop Outer_Loop;

end AoC_2020_01;

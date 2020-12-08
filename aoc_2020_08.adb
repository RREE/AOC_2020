pragma Ada_2020;

with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Containers.Vectors;

procedure AoC_2020_08 is

   Input_Filename : constant string := "input_08.txt";
   Input_File     : File_Type;

   type Code is (Acc, Jmp, Nop);
   subtype Arg is Integer;

   type Instruction is record
      C : Code;
      A : Arg;
   end record;

   package Instructions is new Ada.Containers.Vectors (Positive, Instruction);
   use Instructions;
   Inst : Instructions.Vector := Empty_Vector;

   package Code_IO is new Ada.Text_IO.Enumeration_IO (Code);
   use Code_IO;

begin
   Open (Input_File, In_File, Input_Filename);
   while not End_Of_File (Input_File) loop
      Read_Instructions:
      declare
         I : Instruction;
      begin
         Get (Input_File, I.C);
         Get (Input_File, I.A);
         Inst.Append (I);
      end Read_Instructions;
   end loop;

   declare
      Accumulator : Integer := 0;
      subtype Instruction_Index is Extended_Index range 1 .. Extended_Index(Inst.Length);
      Visited : array (Instruction_Index) of Boolean := (others => False);
      PC  : Instruction_Index := 1;
      I : Instruction;
   begin
      while not Visited (Pc) loop
         I := Inst (Pc);
         Visited (Pc) := True;
         case I.C is
         when Acc =>
            Accumulator := @ + I.A;
            Pc := @ + 1;
         when Nop =>
            Pc := @ + 1;
         when Jmp =>
            Pc := @ + I.A;
         end case;
      end loop;
      Put_Line ("PC before second execution:" & PC'Image & ", Acc:" & Accumulator'Image);
   end;


exception
when Name_Error =>
   Ada.Text_IO.Put_Line ("file not found: '" & Input_Filename & "'");
end AoC_2020_08;

with Tokenizer;              use Tokenizer;
with Ada.Text_IO;            USE Ada.Text_IO;

procedure Main is

begin
   --  Insert code here.
   Tokenizer.open("../src/main.adb");

   declare
      ch : Token_Type := next_token;
   begin
      put_line( Token_Code'Image( ch.typeOf ) );
      put_line( "identifier: '" & ch.identifier & "'");
   end;


end Main;

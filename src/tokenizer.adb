with ada.text_io;   use ada.text_io;


package body tokenizer is
   input                : file_type;
   line                 : String( 1..100 );
   last                 : natural :=0;
   next                 : natural :=0;

   ----------
   -- open --
   ----------
   procedure open( name : in String ) is
   begin
      ada.text_io.open (file => input, mode => ada.text_io.in_file, name => name);
   end;

   ----------------
   -- next_char  --
   ----------------
   function next_char return Token_Type is
      ch                : character;
      result            : Token_Type;
   begin
      if end_of_file( input ) then
         result.typeOf := End_Of_File;
         return result;
      end if;

      if next = last then
         get_line(input,line, last);
         put_line("file=" & line(1..last) );
         next := 0;
      end if;

      ch := line(next);

      next := next + 1;

      result.typeOf := T_Char;
      result.value(2) := ch;

      return result;
   end next_char;

   --------------------
   -- Is_End_Of_Line --
   --------------------
   Function Is_End_Of_Line Return Boolean is
   begin
      return Next = Last;
   end Is_End_Of_Line;

   ---------------
   -- next_word --
   ---------------
   function next_token return Token_Type is
      ch                : Token_Type := next_char;
      State             : enum ( S_Null, S_Identifier, S_Sring, S_Comment, S_END );
   begin
      while not ch.typeOf = End_Of_File loop
         declare
         begin
         case State is
         when S_Null =>
            if ch in 'a'..'z' or  ch in 'A'..'Z' or ch in '0'..'9' then
               state := S_Identifier;
            end if;

            if ch = '-' then
               ch := next_char;
               if ch = '-' then
                  State := S_comment;
               end if;
            end if;

         when S_Comment =>
            while not is_end_of_line loop
               ch := next_char;
            end loop;

         when S_Identifier =>
            if not (ch in 'a'..'z') or (ch in 'A'-'z') or (ch in '0'..'9' ) then
               state := S_Null;
            end if;

            identifier(k) := ch;
            k := k + 1;

            end case;
         end;
      end loop;

      return;
   end next_token;





end tokenizer;


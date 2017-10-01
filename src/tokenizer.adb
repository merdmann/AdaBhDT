with ada.text_io;   use ada.text_io;


package body tokenizer is
   input                : file_type;
   line                 : String(1..100);
   last                 : natural :=1;
   next                 : natural :=1;

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
      result.typeOf := T_Character;

      if end_of_file( input ) then
         result.typeOf := End_Of_File;
         return result;
      end if;

      if next = last then
         get_line(File => input, item =>line, last => last);
         next := 1;
      end if;

      if next in line'Range then
         ch := line(next);

         next := next + 1;
      else
         Put_Line("next: " & Natural'Image(next));
      end if;


      result.char := ch;

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
      Result            : Token_Type;
      ch                : character := next_char.char;
      type State_Type  is ( S_Null,
                            S_Identifier,
                            S_Number,
                            S_String,
                            S_Comment,
                            S_END );
      State             : State_Type := S_Null;
   begin
      while not end_of_file( input ) and state /= S_END loop
         case State is
         -- ..................................................................
         when S_Null =>
            if ch in 'a'..'z' or  ch in 'A'..'Z' then
               state := S_Identifier;
               result.typeOf := T_Identifier;
            end if;

            if ch in '0'..'9' then
               state := S_Number;
               result.typeOf := T_Number;
            end if;

            --................................................................
            if ch = '-' then
               ch := next_char.char;
               if ch = '-' then
                  State := S_comment;
               end if;
            end if;

            --................................................................
            if ch = '"' then
               State := S_String;
            end if;

         -- ..................................................................
         when S_Comment =>
            while not is_end_of_line loop
               ch := next_char.char;
            end loop;

         when S_Number =>
            if ch in '0'..'9' then
               result.number(result.length) := ch;
               result.length := result.length + 1;
               result.typeOf := T_Number;
            else
               state := S_END;
            end if;

         -- ..................................................................
         when S_String =>
            if ch = '"' then
               state := S_Null;
            end if;

         -- ..................................................................
         when S_Identifier =>
            if not (ch in 'a'..'z') or (ch in 'A'..'z') or (ch in '0'..'9' ) then
               State := S_End;
            else
               result.identifier(result.length) := ch;

               if result.length in result.identifier'Range then
                  result.length := result.length + 1;
               else
                  put_line( "to long; chars discarded");
               end if;
            end if;
         -- ..................................................................
         when S_end =>
            null;
         end case;
      end loop;

      return result;
   end next_token;





end tokenizer;


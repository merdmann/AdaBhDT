package Tokenizer is

   procedure open( name : in String );

   type Token_Code is ( Identifier, Keyword, T_String, Number, End_Of_File,
                     Null_Token, T_Char);

   type Token_Type is record
      typeOf  : Token_Code := Null_Token;
      value   : String( 1..100 ) := (others=>' ');
   end record;

   function next_token return Token_Type;

end Tokenizer;

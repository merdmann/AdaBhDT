package Tokenizer is

   procedure open( name : in String );

   type Token_Code  ( Identifier, Keyword, T_String, Number, End_Of_File, Null_Token);
   type Token_Type is record
      typeOf  : Token_Type Null_Token
      value   : String( 1..100 );
   end record:

   function next_token return Token_Type;

end Tokenizer;

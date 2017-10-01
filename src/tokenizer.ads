package Tokenizer is

   procedure open( name : in String );

   type Token_Code is ( Null_Token,
                        T_Identifier,
                        T_Keyword,
                        T_String,
                        T_Number,
                        T_Character,
                        End_Of_File);

   ----------------
   -- Tpken_Type --
   ----------------
   type Token_Type is record
      typeOf        : Token_Code :=  Null_Token;
      lastread      : Character  := ' ';
      pushback      : Character  := ' ';

      length        : Natural := 0;
      char          : Character := ' ';
      identifier    : String( 1..100 )  := ( others => ' ');
      keyword       : String( 1..30 )   := ( others => ' ');
      number        : String( 1..1024 ) := ( others => ' ');
      text          :  String(1..512 )  := ( others => ' ');
   end record;


   function next_token return Token_Type;

end Tokenizer;

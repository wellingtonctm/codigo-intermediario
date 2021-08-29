%{
  #include <string.h>
  #include "exp.tab.h"
  #define YY_DECL int yylex()
%}

%%

[ \t]                 {;} // Ignorar
\n                    {return T_NEWLINE;}
"exit"                {return T_EXIT;}
"="                   {return T_ATT;}
"+"                   {return T_SUM;}
"-"                   {return T_SUB;}
"*"                   {return T_MULT;}
"/"                   {return T_DIV;}
"("                   {return T_LPAR;}
")"                   {return T_RPAR;}
[A-Za-z][A-Za-z0-9_]* {sprintf(yylval.Str, "%s", yytext); return T_NAME;}
[0-9]+(\.[0-9]+)?     {sprintf(yylval.Str, "%s", yytext); return T_NUM;}

%%
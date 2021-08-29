%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #define YY_DECL int yylex()
    #include "exp.tab.h"
%}

%%

[ \t]                 {;} // Ignorar
\n                    {return T_NEWLINE;}
"exit"                {return T_EXIT;}
[A-Za-z][A-Za-z0-9_]* {strcpy(yylval.str, yytext); return T_NAME;}
[0-9]+                {strcpy(yylval.str, yytext); return T_INT;}
[0-9]+\.[0-9]+        {strcpy(yylval.str, yytext); return T_FLOAT;}
"="                   {return T_ATR;}
"+"                   {return T_SUM;}
"-"                   {return T_SUB;}
"*"                   {return T_MULT;}
"/"                   {return T_DIV;}
"("                   {return T_LPAR;}
")"                   {return T_RPAR;}

%%
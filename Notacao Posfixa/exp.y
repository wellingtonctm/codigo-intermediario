%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	extern int yylex();
	extern int yyparse();
	extern FILE* yyin;

	void yyerror(const char* s);
%}

%union {
	int ival;
	float fval;
	char str[1500];
}

/* Constantes */

%token<str> T_INT
%token<str> T_FLOAT
%token<str> T_NAME
%token T_ATR
%token T_SUM T_SUB T_MULT T_DIV T_LPAR T_RPAR
%token T_NEWLINE T_EXIT

%left T_SUM T_SUB
%left T_MULT T_DIV

%type<str> exp_i
%type<str> exp_f
%type<str> atr

/* Símbolo Inicial */
%start calc

%%

calc:
	| calc line
;

line: T_NEWLINE
     | atr T_NEWLINE           {printf(">>> RPN: %s\n", $1);}
	| T_EXIT T_NEWLINE        {printf(">>> Tchau!\n"); exit(0);}
;

atr: T_NAME T_ATR exp_i        {sprintf($$, "%s %s =", $1, $3);}
   | T_NAME T_ATR exp_f        {sprintf($$, "%s %s =", $1, $3);}
;

exp_f: T_FLOAT                 {sprintf($$, "%s", $1);}
     | exp_f T_SUM exp_f       {sprintf($$, "%s %s +", $1, $3);}
     | exp_f T_SUB exp_f       {sprintf($$, "%s %s -", $1, $3);}
     | exp_f T_MULT exp_f      {sprintf($$, "%s %s *", $1, $3);}
     | exp_f T_DIV exp_f       {sprintf($$, "%s %s /", $1, $3);}
     | T_LPAR exp_f T_RPAR     {sprintf($$, "%s", $2);}
     | exp_i T_SUM exp_f       {sprintf($$, "%s %s +", $1, $3);}
     | exp_i T_SUB exp_f       {sprintf($$, "%s %s -", $1, $3);}
     | exp_i T_MULT exp_f      {sprintf($$, "%s %s *", $1, $3);}
     | exp_i T_DIV exp_f       {sprintf($$, "%s %s /", $1, $3);}
     | exp_f T_SUM exp_i       {sprintf($$, "%s %s +", $1, $3);}
     | exp_f T_SUB exp_i       {sprintf($$, "%s %s -", $1, $3);}
     | exp_f T_MULT exp_i      {sprintf($$, "%s %s *", $1, $3);}
     | exp_f T_DIV exp_i       {sprintf($$, "%s %s /", $1, $3);}
     | exp_i T_DIV exp_i       {sprintf($$, "%s %s /", $1, $3);}
;

exp_i: T_INT                   {sprintf($$, "%s", $1);}
     | exp_i T_SUM exp_i       {sprintf($$, "%s %s +", $1, $3);}
     | exp_i T_SUB exp_i       {sprintf($$, "%s %s -", $1, $3);}
     | exp_i T_MULT exp_i      {sprintf($$, "%s %s *", $1, $3);}
     | T_LPAR exp_i T_RPAR     {sprintf($$, "%s", $2);}
;

%%

// yyparse() retorna 0 quando há sucesso e diferente de 0 quando falha

int main() {
	yyin = stdin;

	do {
		yyparse();
	} while (!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Erro Sintático: %s\n", s);
	exit(1);
}
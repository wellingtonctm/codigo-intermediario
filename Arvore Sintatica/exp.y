%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "latexTree.h"

  extern int yylex();
  extern int yyparse();
  extern FILE* yyin;

  void yyerror(const char* s);
%}

%union {
  char Str[20];
  struct node *Node;
}

%token<Str> T_NUM
%token<Str> T_NAME
%token T_ATT
%token T_SUM T_SUB T_MULT T_DIV T_LPAR T_RPAR
%token T_NEWLINE T_EXIT

%left T_SUM T_SUB
%left T_MULT T_DIV

%type<Node> id
%type<Node> attr
%type<Node> expr

// Símbolo inicial
%start calc



%%

calc:
    | calc line
;

line: T_NEWLINE           {;}
    | attr                {print($1);}
    | T_EXIT T_NEWLINE    {printf("Tchau!\n"); exit(0);}
;

attr: id T_ATT expr       {$$ = new_node("A", $1, new_node("=", NULL, NULL, NULL), $3);}

id: T_NAME                {$$ = new_node($1, NULL, NULL, NULL);};

expr: T_NUM               {$$ = new_node($1, NULL, NULL, NULL);}
    | T_NAME              {$$ = new_node($1, NULL, NULL, NULL);}
    | expr T_SUM expr     {$$ = new_node("E", $1, new_node("+", NULL, NULL, NULL), $3);}
    | expr T_SUB expr     {$$ = new_node("E", $1, new_node("-", NULL, NULL, NULL), $3);}
    | expr T_MULT expr    {$$ = new_node("E", $1, new_node("*", NULL, NULL, NULL), $3);}
    | expr T_DIV expr     {$$ = new_node("E", $1, new_node("/", NULL, NULL, NULL), $3);}
    | T_LPAR expr T_RPAR  {$$ = new_node("E", new_node("(", NULL, NULL, NULL), $2, new_node(")", NULL, NULL, NULL));}
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
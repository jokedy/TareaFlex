%{
/*Libraries*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
FILE *yyin;
%}

/*OPTIONS SECTION*/
/* This tells Flex to read a single input file*/
%option noyywrap
/*This will allow us to get the line number*/
%option yylineno
LETTER          [a-zA-Z]
DIGIT           [0-9]

ID	            {LETTER}({LETTER}|{DIGIT})*

/*Palabras Claves*/
WHERE 	        [W|w][H|h][E|e][R|r][E|e]
FROM	        [F|f][R|r][O|o][M|n]
SELECT	        [S|s][E|e][L|l][E|e][C|c][T|t]

/*RULES AND SEMANTIC ACTION SECTION*/
%%

{WHERE} 	    { printf("\nPC: (%s)", yytext); }
{FROM} 		    { printf("\nPC:(%s)", yytext); }
{SELECT}	    { printf("\nPC: (%s)", yytext);}
{ID}		    { printf("\nID: (%s)", yytext);}

"\n"
"\t"
" "
%%

int main(int argc, char *argv[])
{
    if( (yyin = fopen(argv[1], "rt")) == NULL){
        printf("\nCould not open file: %s\n", argv[1]);
        return 1;
    }
    else{
        printf("\nSuccessfully open file", argv[1]);
        yylex();
    }
    printf("\nFLEX has finished reading the file");
    fclose(yyin);
    return 0;
}
/*define si esta dentro del rango*/
int fn_checkran(char *ptr)
{
    int value = atoi(ptr);
    if( value < -32768 || value > 32768 )
    {
        printf("Error: variable out of range");
        return yyerror();
    }    
}

/*manda el Error*/
int yyerror(void){
    printf("\n Lexical Error: Invalid Character: %s \n", yytext);
    exit(1);
}
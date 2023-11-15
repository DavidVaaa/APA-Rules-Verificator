import java_cup.runtime.*;
%%
%class Lexer
%line
%column
%cup
   
%{  
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
   
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}
   


LineTerminator = \r|\n|\r\n

WhiteSpace     = {LineTerminator} | [\t\f]

token1    = {author}
author = [A-Za-z\s,.]+

token2    = {year}
year = (202[0-3] | 20[0-1][0-9] | 2[0-9][0-9] | [0-1]?[0-9]?[0-9])

token3    = {title}
title = [A-Za-z0-9\s,]+

token4    = {publisher}
publisher = [A-Za-z0-9\s,]+

DOT = \.

%%
/* ------------------------Lexical Rules Section----------------------*/

<YYINITIAL> {

"token1"                { System.out.print(yytext()); return symbol(sym.TOKEN1); }
"token2"      { System.out.print(yytext());
                         return symbol(sym.TOKEN2, Integer.valueOf(yytext())); }
"token3"                { System.out.print(yytext()); return symbol(sym.TOKEN3); }
"token4"                { System.out.print(yytext()); return symbol(sym.TOKEN4); }
}
/*
    // Expresión regular para el nombre del autor
    [A-Za-z'\n,.]+

    // Expresión regular para la coma que separa el apellido del autor y la fecha
    "(" { yybegin(YEAR); }
}

<YEAR> {
    // Expresión regular para el año de publicación
    [0-9]{4}

    // Expresión regular para la coma que separa la fecha y el título
    ")" { yybegin(TITLE); }
}

<TITLE> {
    // Expresión regular para el título del libro
    [A-Za-z0-9\s,]+

    // Expresión regular para el punto que separa el título de la editorial
    "." { yybegin(PUBLISHER); }
}

<PUBLISHER> {
    // Expresión regular para el nombre de la editorial
    [A-Za-z0-9\s,]+
    {
        System.out.println(yytext());
        yybegin(INITIAL);
    }
}



/* No token was found for the input so through an error.  Print out an
   Illegal character message with the illegal character that was found. */
[^]                    { throw new Error("Illegal character"+ yytext()); }
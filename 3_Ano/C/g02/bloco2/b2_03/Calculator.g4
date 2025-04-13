grammar Calculator;

program:
    stat* EOF ;                 // Zero ou mais declarações (ou expressões), seguidas pelo final do arquivo (EOF)
                                // "EOF" indica que a entrada deve terminar quando não houver mais nada a ser lido.

stat:
    expr? NEWLINE ;             // Uma expressão opcional seguida de uma nova linha (NEWLINE)
                                // O "?" significa que "expr" é opcional e a linha pode ter ou não uma expressão antes da nova linha.

expr:

        op=( '-' | '+' ) expr               #ExprUnary
    |   expr op=( '*' | '/' | '%' ) expr    #ExprMultDivMod        
    |   expr op=( '+' | '-' ) expr          #ExprAddSub        
    |   Integer                             #ExprInteger   
    |   '(' expr ')'                        #ExprParent     
    ;  

Integer: [0-9]+;


NEWLINE: '\r'? '\n' ;               // Nova linha, com suporte opcional para retorno de carro (\r)
                                    // A parte '\r' é opcional, já que nem todos os sistemas operacionais utilizam retorno de carro.

WS: [ \t]+ -> skip;             // Ignora espaços em branco durante o parsing
                                // O "skip" significa que esses caracteres não influenciam o processo de análise

COMMENT: '#' .*? '\n' -> skip;
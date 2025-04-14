grammar PrefixCalculator;

program:
    stat* EOF ;                 // Zero ou mais declarações (ou expressões), seguidas pelo final do arquivo (EOF)
                                // "EOF" indica que a entrada deve terminar quando não houver mais nada a ser lido.

stat:
    expr? NEWLINE ;             // Uma expressão opcional seguida de uma nova linha (NEWLINE)
                                // O "?" significa que "expr" é opcional e a linha pode ter ou não uma expressão antes da nova linha.

expr:
      op=( '*' | '/' | '+' | '-' ) expr expr    #ExprPrefix     // expressão prefixa (+ 3 3)
    | Number                                    #ExprNumber     // expressao pode ser um numero apenas
    ; 

Number: [0-9]+ ('.' [0-9]+)? ;      // Número real com ponto fixo (pode ser um número inteiro ou decimal)
                                    // [0-9]+ -> Um ou mais dígitos de 0 a 9 (parte inteira do número)
                                    // ('.' [0-9]+) -> Parte decimal, se presente, com ponto seguido de um ou mais dígitos
                                    // "?" -> A parte decimal é opcional, ou seja, pode ser um número inteiro ou decimal

NEWLINE: '\r'? '\n' ;               // Nova linha, com suporte opcional para retorno de carro (\r)
                                    // A parte '\r' é opcional, já que nem todos os sistemas operacionais utilizam retorno de carro.

WS: [ \t]+ -> skip;             // Ignora espaços em branco durante o parsing
                                // O "skip" significa que esses caracteres não influenciam o processo de análise

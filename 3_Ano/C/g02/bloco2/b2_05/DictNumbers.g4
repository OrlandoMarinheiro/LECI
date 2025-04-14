grammar DictNumbers;

program: 
    stat* EOF;                  // uma ou mais repetições de stat até ao final do ficheiro
                                // '*' -> ler varias linhas / 'EOF' -> garantir que o parser termine quando não houver mais dados
stat:
    expr NEWLINE;               // expressão seguida de '\n'  

expr:
    Integer '-' Word;

Word: [a-z]+;
Integer: [0-9]+;

NEWLINE: '\r'? '\n' ;           // Nova linha, com suporte opcional para retorno de carro (\r)
                                // A parte '\r' é opcional, já que nem todos os sistemas operacionais utilizam retorno de carro.

WS: [ \t]+ -> skip;             // Ignora espaços em branco durante o parsing
                                // O "skip" significa que esses caracteres não influenciam o processo de análise

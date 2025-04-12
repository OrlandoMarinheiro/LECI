grammar Hello;                  // Define o nome da gramática como Hello

saudacao : (bye | greetings)* ; // definir regra com mais que uma alternativa / "*" é usado para poder identificar 0 ou varias saudações, enquanto que sem, só identifica uma

greetings : 'hello' name ;      // Reconhece a palavra-chave 'hello' seguida de um ID

bye : 'bye' name ;              // Reconhece a palavra-chave 'bye' seguida de um ID

name : ID + ;                   // permitir nomes com mais que um identificador

ID : [a-zA-Z]+ ;                // Um ID é composto por uma ou mais letras minúsculas ou maiúsculas

WS : [ \t\r\n]+ -> skip ;       // Ignora (salta) espaços, tabs e quebras de linha

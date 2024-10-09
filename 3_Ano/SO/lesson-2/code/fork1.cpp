#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

#include "delays.h"
#include "process.h"

int main(void)
{
  printf("Before the fork: PID = %d, PPID = %d\n", getpid(), getppid());

  int a = pfork(); // equivalent to fork(), dealing internally with error situations
  printf("PID do filho criado: %d\n", a);

  if (a == 0){

    printf("Eu sou o filho\n");
    printf("After the fork: PID = %d, PPID = %d\n",getpid(), getppid());

  } else {
    
    printf("Eu sou o pai\n");
    printf("After the fork: PID = %d, PPID = %d\n",getpid(), getppid());

  }
  bwRandomDelay(0, 200); // added to enhance the occurrence of different outputs
  printf("  Was I printed by the parent or by the child process? How can I know it?\n");
  
  
  return EXIT_SUCCESS;
}

  // a) 1º
  // A resposta depende do valor retornado pela função fork(), isto é, se for 0 é impressa pelo processo filho, caso contrario é impressa pelo processo pai
  // Podemos verificar isso através da utilização de uma condição


  // a) 2º
  /*
  #include <stdio.h>
  #include <stdlib.h>
  #include <sys/types.h>
  #include <unistd.h>

  #include "delays.h"
  #include "process.h"

  int main(void)
  {
  printf("Before the fork: PID = %d, PPID = %d\n", getpid(), getppid());

  pfork(); // equivalent to fork(), dealing internally with error situations
  
  printf("After the fork: PID = %d, PPID = %d\n",getpid(), getppid());
  bwRandomDelay(1000, 100000); // added to enhance the occurrence of different outputs
  printf("  Was I printed by the parent or by the child process? How can I know it?\n"); 
  
  return EXIT_SUCCESS;
  }*/

  // A razão de aparecerem 5 linhas no terminal sabendo que são apenas invocados 3 printf (programa default acima), é derivado ao facto de após a chamada da função 
  // fork() o programa será executado pelo pai e pelo filho


  // a) 3º
  // Isto acontece devido à concorrencia e à forma como o sistema gere varios processos em execução
  


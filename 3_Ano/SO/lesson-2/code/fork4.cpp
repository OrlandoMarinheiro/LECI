#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#include "delays.h"
#include "process.h"

int main(void)
{
  printf("Before the fork: PID = %d, PPID = %d\n", getpid(), getppid());

  pid_t ret = pfork();
  if (ret == 0)
  {
    execl("./child", "./child", NULL);
    //perror("execl failed"); // Mensagem de erro
    printf("why doesn't this message show up?\n");
    return EXIT_FAILURE;
  }
  else
  {
    //pwait(NULL);
    printf("I'm the parent: PID = %d, PPID = %d\n", getpid(), getppid());
    usleep(1000);
  }

  return EXIT_SUCCESS;
}


// a) 2º
// Não aparece a mensagem depois do execl pois este substitui o processo atual por outro programa.
// No caso do execl ser bem sucessido a próxima linha não é retornada. 
// Pode ser utilizado perror("execl failed"); depois de execl

// a) 3º
// Serve para identificar o executável e garantir que ele possa chamar o seu propio nome

// a) 4º
// O segundo valor do PPID representa o processo que ainda está em execução(processo pai)
// O bash prompt aparece antes da segunda mensagem devido ao comportamente assincrono dos processos, isto é,
// o processo pai termina a sua execução antes de o Bash mostrar o prompt, mesmo que o processo filho ainda não tenha terminado de imprimir a sua mensagem.
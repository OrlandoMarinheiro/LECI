#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

#include "delays.h"
#include "process.h"

int main(void)
{
  printf("Before the fork: PID = %d, PPID = %d\n", getpid(), getppid());

  pid_t ret = pfork();
  if (ret == 0)
  {
    bwRandomDelay(0, 200);
    printf("After the fork, in the child: PID = %d, PPID = %d\n", getpid(), getppid());
  }
  else
  {
    bwRandomDelay(100, 100000);
    printf("After the fork, in the parent: PID = %d, PPID = %d\n", getpid(), getppid());
    //pwait(NULL); // bloqueia todos os processos do pai até que os do filho sejam concluídos

  }

  return EXIT_SUCCESS;
}


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

  printf("After the fork: PID = %d, PPID = %d\n",getpid(), getppid());
  bwRandomDelay(0, 10000);
  printf("  [ret = %d] Was I printed by the parent or by the child process? How can I know it?\n", ret); 

  return EXIT_SUCCESS;
}


// b) 2º
// [ret = 11531] processo pai | [ret = 0] processo filho


// b) 3º
// Se ret = 0 trata-se do processo filho, caso contrario se ret = 11531 trata-se do processo pai


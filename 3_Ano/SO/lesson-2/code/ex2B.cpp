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

    if (ret == 0) {
        // esperar que os processos do filho sejam terminados antes dos processos do pai
        execl("/bin/ls", "ls", "-l", NULL);

    } else {
        for (int symbol = 1; symbol <= 40; symbol++){
            printf("=");
        }
        printf("\n");
        pwait(NULL);
        for (int symbol = 1; symbol <= 40; symbol++){
            printf("=");
        }
        printf("\n");
    }

}
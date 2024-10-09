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
        for (int cnt_child = 1; cnt_child <= 10; cnt_child++)
        {
            printf("Child: %d\n", cnt_child);
            usleep(10000); // delay entre cada printf
            
        }
        
    } else {
        // esperar que os processos do filho sejam terminados antes dos processos do pai
        pwait(NULL);
        for (int cnt_parent = 11; cnt_parent <= 20; cnt_parent++)
        {
            printf("Parent: %d\n", cnt_parent);
            usleep(10000); // delay entre cada printf
        }
    }
    return EXIT_SUCCESS;
}


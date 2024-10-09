#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

#include <sys/types.h>
#include <signal.h>


int main(int argc, char *argv[])
{

    if (argc != 2){
        printf("Must be used %s with «PID»\n", argv[0]);
    } else {
        
        pid_t pid = atoi(argv[1]); //converter o segundo argumento num inteiro

        if (kill(pid, SIGINT) == 0){ // Caso for igual a 0 a operação foi realizada com sucesso
            printf("Process %d killed!\n", pid);
        } else {
            printf("Process not Killed!\n");
        }
    }

}

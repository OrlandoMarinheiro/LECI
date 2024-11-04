#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <libgen.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>

#include "utils.h"
#include "thread.h"
#include "fifo.h"

int N2;
int counter = 0;

void *threadSecundaria(void *arg) {
    
    printf("Insira um número entre 10 e 20: ");
    scanf("%d", &N2);

    while (N2 < 10 || N2 > 20 ){  // N1 entre 0 e 9
        printf("%d não está entre 1 e 9! Insira novamente um número: ", N2);
        scanf("%d", &N2);
    }

    counter --;
    while (counter < N2){
        counter++;
        printf("[SECUNDARIA]: %d\n", counter);
        usleep(100000);
    }
    return NULL;
}

int main() {
    int N1;

    printf("Insira um número entre 1 e 9: ");
    scanf("%d", &N1);

    while (N1 < 1 || N1 > 9 ){  // N1 entre 0 e 9
        printf("%d não está entre 1 e 9! Insira novamente um número: ", N1);
        scanf("%d", &N1);
    }

    counter = N1;

    pthread_t secundaria;
    thread_create(&secundaria, NULL, threadSecundaria, (void *)(&N2));
    thread_join(secundaria, NULL);


        while (counter != 1) {
            counter --;
            printf("[PRINCIPAL]: %d\n", counter);
            usleep(100000);
        }

    



return 0;
}

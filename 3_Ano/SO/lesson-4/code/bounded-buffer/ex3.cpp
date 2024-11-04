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

int counter;
int troca;

pthread_mutex_t thread_access;            
pthread_cond_t sec1, sec2;

void *threadSecundaria1(void *arg) {
    while (counter > 1) {
        mutex_lock(&thread_access);  // evitar condição de corrida
        
        // enquanto for a vez do thread secundaria1
        while (troca == 2){   
            // thread aguarda enquanto thread secundaria2 não termina
            cond_wait(&sec2, &thread_access);  
        }

        if (counter == 1) {
            mutex_unlock(&thread_access);
            thread_exit(NULL);
        }

        counter --;
        printf("[THREAD 1]: %d | [PID]: %d\n", counter, gettid());
        usleep(100000);


        troca = 2;  

        // envia sinal para thread secundaria2
        cond_broadcast(&sec1);
        
        // desbloqueia o mutex de forma a que o secundaria2 tenha acesso ao counter
        mutex_unlock(&thread_access);

    }
    thread_exit(NULL);
    return NULL;
}



void *threadSecundaria2(void *arg) {
    while (counter > 1) {
        mutex_lock(&thread_access);  // evitar condição de corrida

        // enquanto for a vez do thread secundaria2
        while (troca == 1){  
            // aguardar que o thread secundario1 termine a decremenação do counter 
            cond_wait(&sec1, &thread_access);  
        }

        if (counter == 1) {
            mutex_unlock(&thread_access);
            thread_exit(NULL);
        }

        counter --;
        printf("[THREAD 2]: %d | [PID]: %d\n", counter, gettid());
        usleep(100000);

        troca = 1;

        // envia sinal para thread secundaria1
        cond_broadcast(&sec2);
        
        // desbloqueia o mutex de forma a que o secundaria1 tenha acesso ao counter
        mutex_unlock(&thread_access);

    }
    thread_exit(NULL);
    return NULL;
}


int main() {
    int N1;

    printf("Insira um número entre 10 e 20: ");
    scanf("%d", &N1);

    while (N1 < 10 || N1 > 20 ){  // N1 entre 0 e 9
        printf("%d não está entre 1 e 9! Insira novamente um número: ", N1);
        scanf("%d", &N1);
    }

    counter = N1;

    troca = 1; // secundaria1 -> 1 e secundaria2 -> 2

    mutex_init(&thread_access, NULL);
    cond_init(&sec1, NULL);
    cond_init(&sec2, NULL);


    pthread_t secundaria1;
    pthread_t secundaria2;

    thread_create(&secundaria1, NULL, threadSecundaria1, NULL);
    thread_create(&secundaria2, NULL, threadSecundaria2, NULL);

    thread_join(secundaria1, NULL);
    thread_join(secundaria2, NULL);

 

    mutex_destroy(&thread_access);
    cond_destroy(&sec1);
    cond_destroy(&sec2);


return 0;
}

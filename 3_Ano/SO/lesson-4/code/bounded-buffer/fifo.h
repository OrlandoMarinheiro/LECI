/*
 * Definition of the FIFO data type and manipulating functions
 *
 * The fifo is defined for a maximum capacity of N items
 */

#ifndef __SO_FSO_2425_IPC_FIFO__
#define __SO_FSO_2425_IPC_FIFO__

#include <stdint.h>
#include <stdlib.h>

#include "thread.h"

#define N 200

struct Item
{ 
    uint32_t id; // id of the producer
    uint32_t v1; // a general purpose field
    uint32_t v2; // another general purpose field
};

struct Fifo
{
    uint32_t count;
    uint32_t in, out;
    Item data[N];

    /* support for safeness, not used in the unsafe version */

    // Segurança de acesso à estrutura
    pthread_mutex_t access;                 // mutex para controlar o acesso à estrutura, garantindo que apenas uma thread acesse a estrutura de cada vez
    pthread_cond_t notFull, notEmpty;       // variáveis de condição para controlar a inserção e remoção de elementos da estrutura
};

void fifoInit(Fifo *f);

void fifoInsert(Fifo *f, Item item);

Item fifoRetrieve(Fifo *f);

void fifoDestroy(Fifo *f);

#endif // __SO_FSO_2425_IPC_FIFO__

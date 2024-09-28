#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>

#include "linked-list.h"

/*******************************************************/

SllNode* sllDestroy(SllNode* list)
{

    while(list != NULL) {
        delete(list->reg.name);
        delete(list);
        list = list->next;
    }
    return NULL;
}
/*******************************************************/

void sllPrint(SllNode *list, FILE *fout)
{
    while (list != NULL){
        fprintf(fout, "Nmec: %u, Student Name: %s\n", list->reg.nmec, list->reg.name);
        list = list->next;
    }
}

/*******************************************************/

SllNode* sllInsert(SllNode* list, uint32_t nmec, const char *name){
    SllNode *new_student = (SllNode*)malloc(sizeof(SllNode));

    // Verifica se a alocação foi bem-sucedida
    if (new_student == NULL) {
        printf("Erro ao criar o nó!");
        return NULL;
    }

    new_student->reg.nmec = nmec;
    new_student->reg.name = strdup(name);
    new_student->next = NULL;

    // verificar se o nó está vazio, se sim, vai retornar apenas student, pois é o unico nó existente
    if (list == NULL) {
        return new_student; 
    }
    // se o nó atual for maior que o nó novo(student), o proximo nó aponta para list()
    if (list->reg.nmec > nmec) {
        new_student->next = list; 
        return new_student; 
    }

    SllNode *current = list;

    while (current->next != NULL && current->next->reg.nmec < nmec) {
        current = current->next; 
    }

    new_student->next = current->next; 
    current->next = new_student; 

    return list; 
}


/*******************************************************/

bool sllExists(SllNode* list, uint32_t nmec)
{   
    while (list != NULL){
        if (list->reg.nmec == nmec){
            return true;
        }
        list = list->next; 
    }
    return false;
}

/*******************************************************/

SllNode* sllRemove(SllNode* list, uint32_t nmec)
{
    assert(list != NULL);
    assert(sllExists(list, nmec));

    SllNode* current = list;
    SllNode* previous = NULL;

    // Percorre a lista para encontrar o nó com o nmec correspondente
    while (current != NULL)
    {
        if (current->reg.nmec == nmec) {
            SllNode* next = current->next;
            
            if (previous == NULL) {
                return next; 
            }

            // liga o nó anterior ao próximo nó
            previous->next = next;
            return list; 
        }

        previous = current;
        current = current->next;
    }

    return list;
}


/*******************************************************/

const char *sllGetName(SllNode* list, uint32_t nmec)
{
    assert(list != NULL);
    assert(sllExists(list, nmec));

    SllNode *current = list;
    while (current != NULL) {
        if (current->reg.nmec == nmec){
            return current->reg.name;
        }
        current = current->next;
    }
    return NULL;
}

/*******************************************************/

SllNode* sllLoad(SllNode *list, FILE *fin, bool *ok)
{
    assert(fin != NULL);

    if (ok != NULL)
       *ok = false; // load failure

    char line[256];
    while (fgets(line, sizeof(line), fin)) {
        
            // determinar indice de até onde termina o nmec (";")
            int index_nmec = 0;
            int length_line = sizeof(line) - 1;

            for (int i = 0; i < length_line; i++)
            {
                if(line[i] != ';') {
                    index_nmec += 1;
                } else{
                    break;
                }
            }

            // converter a junção dos caracteres nmec em inteiros
            
            char temp[index_nmec];
            strncpy(temp ,line, index_nmec);
            temp[index_nmec] = '\0';
            int nmec = atoi(temp);
            
            //Extrair nome do respetico nmec, isto é, indice do nmec até ao final da linha
            int index_name = index_nmec + 1;
            for (int i = index_name; i < length_line; i++)
            {
                if (line[i] != '\0'){
                    index_name += 1;
                } else {
                    break;
                }
            }

            // juntar os caracteres do nome numa string
            int name_length = index_name - index_nmec;
            char name[name_length];
            strncpy(name, &line[index_nmec + 1], name_length - 1);
            name[name_length - 1] = '\0'; 

            list = sllInsert(list,nmec,name);

    }
    return list;
}

/*******************************************************/

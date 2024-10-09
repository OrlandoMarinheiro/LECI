#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>

#include "linked-list.h"

/*******************************************************/

/**
 * \brief The data to be stored in the list
 */
struct Student
{
    uint32_t nmec;        ///< Student number
    char *name;     ///< Student name
};

/**
 * \brief The linked-list support data structure:
 */
struct SllNode 
{
    Student reg;          ///< Student data
    struct SllNode *next;    ///< Pointer to next node
};

/*******************************************************/

static SllNode *list = NULL;

/*******************************************************/

void sllDestroy()
{
    SllNode *current = list;
    while(current != NULL) {
        //armazenar o proximo nó
        SllNode *next = current->next;
        free(current->reg.name);
        free(current);
        current = next;
    }
    current = NULL;
}

/*******************************************************/

void sllPrint(FILE *fout)
{
    while (list != NULL){
        fprintf(fout, "Nmec: %u, Student Name: %s\n", list->reg.nmec, list->reg.name);
        list = list->next;
    }
}
/*******************************************************/

void sllInsert(uint32_t nmec, const char *name)
{
    assert(name != NULL && name[0] != '\0');
    assert(!sllExists(nmec));

    SllNode *new_student = (SllNode*)malloc(sizeof(SllNode));

    new_student->reg.name = strdup(name);
    new_student->reg.nmec = nmec;
    new_student->next = NULL;

    if (list == NULL){
        list = new_student;
        return;
    }

    if (list->reg.nmec > nmec) {
        new_student->next = list;
        list = new_student;
        return;
    }

    SllNode *current = list;

    while( current != NULL && current->next->reg.nmec < nmec){
        current = current->next;
    }

    new_student->next = current->next;
    current->next = new_student;

}

/*******************************************************/

bool sllExists(uint32_t nmec)
{
    while (list != NULL){
        if (list->reg.nmec == nmec) {
            return true;
        }
        list = list->next;
    }
    return false;
}

/*******************************************************/

void sllRemove(uint32_t nmec)
{
    assert(sllExists(nmec));
}

/*******************************************************/

const char *sllGetName(uint32_t nmec)
{
    assert(sllExists(nmec));

    SllNode *current = list;
    while(current != NULL) {
        if(current->reg.nmec == nmec) {
            return current->reg.name;
        }
        current = current->next;
    }
    return NULL;
}

/*******************************************************/

bool sllLoad(FILE *fin)
{
    assert(fin != NULL);

    return false;
}

/*******************************************************/


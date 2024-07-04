//
// Algoritmos e Estruturas de Dados --- 2023/2024
//
// Topological Sorting
//

#include "GraphTopologicalSorting.h"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#include "Graph.h"
#include "IntegersQueue.h"
#include "instrumentation.h"


#define add InstrCount[0]
#define mem InstrCount[1]

struct _GraphTopoSort {
  int* marked;                     // Aux array
  unsigned int* numIncomingEdges;  // Aux array
  unsigned int* vertexSequence;    // The result
  int validResult;                 // 0 or 1
  unsigned int numVertices;        // From the graph
  Graph* graph;
};

// AUXILIARY FUNCTION
// Allocate memory for the struct
// And for its array fields
// Initialize all struct fields
//
static GraphTopoSort* _create(Graph* g) {
  assert(g != NULL);

  GraphTopoSort* p = (GraphTopoSort*)malloc(sizeof(GraphTopoSort));
  if (p == NULL) {
    // erro na alocação de memória
    return NULL;
  }

  // Inicialização dos campos da estrutura
  p->marked = (int*)calloc(GraphGetNumVertices(g), sizeof(int));
  if (p->marked == NULL) {
    // erro na alocação de memória
    free(p);
    return NULL;
  }

  p->numIncomingEdges = (unsigned int*)calloc(GraphGetNumVertices(g), sizeof(unsigned int));
  if (p->numIncomingEdges == NULL) {
    // erro na alocação de memória
    free(p->marked);
    free(p);
    return NULL;
  }

  p->vertexSequence = (unsigned int*)malloc(GraphGetNumVertices(g) * sizeof(unsigned int));
  if (p->vertexSequence == NULL) {
    // erro na alocação de memória
    free(p->marked);
    free(p->numIncomingEdges);
    free(p);
    return NULL;
  }

  p->validResult = 0; // a ordenação topológica ainda não é válida ao inicio
  p->numVertices = GraphGetNumVertices(g);
  p->graph = g;

  return p;
}


//
// Computing the topological sorting, if any, using the 1st algorithm:
// 1 - Create a copy of the graph
// 2 - Successively identify vertices without incoming edges and remove their
//     outgoing edges
// Check if a valid sorting was computed and set the isValid field
// For instance, by checking if the number of elements in the vertexSequence is
// the number of graph vertices
//

int findVertexWithNoIncomingEdges(Graph* g) {
  for (unsigned int v = 0; v < GraphGetNumVertices(g); v++) {
    if (GraphGetVertexDegree(g, v) == 0) {
      return v;
      add++;
      mem+=3;
    }
  }
  return -1;  // No vertex found with no incoming edges
}

GraphTopoSort* GraphTopoSortComputeV1(Graph* g) {
  // Verificações do grafo g
  if (g == NULL || GraphIsDigraph(g) != 1) {
    printf("Grafo inválido!\n");
    mem++;
    return NULL;
  }

  // Criar e iniciar a estrutura
  GraphTopoSort* topoSort = _create(g);
  mem++;

  // verificar se a estrutura foi criada com sucesso
  if (topoSort == NULL) {
    printf("Falha ao criar a estrutura de ordenação topológica!\n");
    return NULL;
  }

  // Criar uma cópia do grafo g
  Graph* gCopy = GraphCopy(g);
  mem++;

  unsigned int v;
  for (v = 0; v < GraphGetNumVertices(gCopy); v++) {
    // Encontrar um vertice sem arestas incidentes
    topoSort->numIncomingEdges[v] = GraphGetVertexInDegree(gCopy, v);
    add++;
    mem+=4;
  }

  unsigned int count = 0;
  unsigned int vertex;
  while (count < GraphGetNumVertices(gCopy)) {
    vertex = GraphGetNumVertices(gCopy);  // Inicializar vertex com um valor que não corresponde a nenhum vértice do grafo
    mem+=2;

    for (unsigned int i = 0; i < GraphGetNumVertices(gCopy); i++) {
      if (topoSort->numIncomingEdges[i] == 0) {
        vertex = i;  // Escolher um vértice com o menor grau
        add++;
        mem+=2;
        break;
      }
    }
    // No caso de passarmos pelos vertices e não encontrarmos um vertice com grau 0 podemos concluir que é um ciclo
    if (vertex == GraphGetNumVertices(gCopy)) {
      printf("Ciclo detetado!\n");
      topoSort->validResult = 0;
      mem++;
      return topoSort;
    }

    printf("ID -> %d\n", vertex); // ID
    topoSort->vertexSequence[count] = vertex;
    mem+=2;
    count++;

    // Obter os vertices adjacentes ao vertice escolhido
    unsigned int* adjacents_Vertex = GraphGetAdjacentsTo(gCopy, vertex);
    unsigned int outDegreeOfVertex = GraphGetVertexOutDegree(gCopy, vertex);
    mem+=2;

    // Remove todas as arestas de saída em vez de remover o vértice inteiro
    for (unsigned int i = 0; i < outDegreeOfVertex; i++) {
      unsigned int adjacent_Vertex = adjacents_Vertex[i + 1];
      GraphRemoveEdge(gCopy, vertex, adjacent_Vertex);
      topoSort->numIncomingEdges[adjacent_Vertex]--;
      mem+=2;
      add+=2;  
    }

    topoSort->numIncomingEdges[vertex] = -1;
    mem++;

    //  Libertação da memoria alocada para o array de vertices adjacentes
    free(adjacents_Vertex);
    mem++;
    topoSort->validResult = 1;
  }
  return topoSort;
}


//
// Computing the topological sorting, if any, using the 2nd algorithm
// Check if a valid sorting was computed and set the isValid field
// For instance, by checking if the number of elements in the vertexSequence is
// the number of graph vertices
//

GraphTopoSort* GraphTopoSortComputeV2(Graph* g) {
  // verificar o grafo g
  if (g == NULL || GraphIsDigraph(g) != 1) {
    printf("Grafo inválido!\n");
    mem++;
    return NULL;
  }

  // iniciar a estrutura topoSort
  GraphTopoSort* topoSort = _create(g);
  mem++;

  if (topoSort == NULL) {
    printf("Falha ao criar a estrutura de ordenação topológica!\n");
    return NULL;
  }

  for (unsigned int v = 0; v < topoSort->numVertices; v++) {
    //registar num array auxiliar o InDegree de cada vértice ( já temos na estrutura numIncomingEdges)
    topoSort->numIncomingEdges[v] = GraphGetVertexInDegree(g, v);
    mem+=3;
    add++;
  }
  unsigned int counter = 0;
  // Enquanto não tivermos visto todos os vértices, executa o ciclo
  while (counter < topoSort->numVertices)
  {
    int v = -1;  // Iniciar v com um valor diferente a todos os vértices do grafo, pois não podem ser negativos
    for (unsigned int vertex = 0; vertex < topoSort->numVertices; vertex++)
    {
      add++;
      mem+=2;
      // verificar se o vertice pode ser visto atraves da condição "numEdgesPerVertex[v] == 0 E não marcado"
      if (topoSort->numIncomingEdges[vertex] == 0 && topoSort->marked[vertex] == 0) {
        // marcar o vertice como visto
        topoSort->marked[vertex] = 1;

        mem+=2;

        v = vertex;

        printf("ID -> %d\n", v); // ID

        // adicionar o vertice à sequencia 
        topoSort->vertexSequence[counter] = vertex;
        counter++;
        mem++;

        // obter os vertices adjacentes a v
        unsigned int* Adjacents_List = GraphGetAdjacentsTo(g, vertex);
        mem++;
        //printf("Adjacents_List -> %d\n", Adjacents_List[0]);

        unsigned int Adjacents_Vertex = Adjacents_List[0];
        mem++;

        for (unsigned int i = 1; i <= Adjacents_Vertex; i++){
          // obter cada vertice w adjacente ao vertice v atual
          unsigned int w = Adjacents_List[i];
          // decrementar o InDegree para cada vertice w adjacente ao v
          topoSort->numIncomingEdges[w]--;
          add++;
          mem+=2;
        }
        // libertar a memoria alocada para o array de vertices adjacentes
        free(Adjacents_List);
        mem++;
        break;
      }
    }
    // no caso de nenhum vertice ter sido encontrado, significa que existe um ciclo
    if (v == -1)
    {
      printf("Ciclo detetado!\n");
      topoSort->validResult = 0;
      mem++;
      return topoSort;
    }
  }
  // ordenação topológica é valida (1)
  topoSort->validResult = 1;
  mem++;

  return topoSort;
} 

  
// Computing the topological sorting, if any, using the 3rd algorithm
// Check if a valid sorting was computed and set the isValid field
// For instance, by checking if the number of elements in the vertexSequence is
// the number of graph vertices
//
GraphTopoSort* GraphTopoSortComputeV3(Graph* g) {
  // verificar o grafo g
  if (g == NULL || GraphIsDigraph(g) != 1) {
    printf("Grafo inválido!\n");
    mem++;
    return NULL;
  }

  // iniciar a estrutura topoSort
GraphTopoSort* topoSort = _create(g);
mem++;

if (topoSort == NULL) {
  printf("Falha ao criar a estrutura de ordenação topológica!\n");
  return NULL;
}

for (unsigned int v = 0; v < topoSort->numVertices; v++)
{
  topoSort->numIncomingEdges[v] = GraphGetVertexInDegree(g, v);
  add++;
  mem+=3;
}

// Cria uma fila para armazenar os vértices com in-degree zero
Queue* queue = QueueCreate(sizeof(unsigned int));
mem++;

if (queue == NULL) {
  printf("Falha ao criar a fila!\n");
  // Libera a memória alocada para a estrutura topoSort
  QueueDestroy(&queue);
  mem++;
  return NULL;
}

// Adiciona os vértices com in-degree zero à fila
for (unsigned int v = 0; v < topoSort->numVertices; v++)
{
  if (topoSort->numIncomingEdges[v] == 0) {
    QueueEnqueue(queue, (int)v);
    add++;
    mem+=2;
  }
}
unsigned int counter = 0;

// Processa a fila até que todos os vértices sejam vistos
while (!QueueIsEmpty(queue)) {
  int v = QueueDequeue(queue);  
  mem++;

  // Armazena o vertice na sequência
  topoSort->vertexSequence[counter] = v;
  counter++;
  mem++;
  add++;

  printf("ID -> %d\n", v); // ID

  // obter os vertices adjacentes a v
  unsigned int* Adjacents_List = GraphGetAdjacentsTo(g, v);
  //printf("Adjacents_List -> %d\n", Adjacents_List[0]);
  unsigned int Adjacents_Vertex = Adjacents_List[0];
  mem+=2;

  for (unsigned int i = 1; i <= Adjacents_Vertex; i++){
    // obter cada vertice w adjacente ao vertice v atual
    unsigned int w = Adjacents_List[i];
    // decrementar o InDegree para cada vertice w adjacente ao v
    add++;
    mem++;
    topoSort->numIncomingEdges[w]--;
    mem++;
    if (topoSort->numIncomingEdges[w] == 0) {
      QueueEnqueue(queue, (int)w);
      mem++;

      }
    }
    free(Adjacents_List);
    mem++;
  }

  // Verificar se todos os vértices foram vistos
  if (counter == topoSort->numVertices) {
    topoSort->validResult = 1;
    mem++;
  }
  else {
    topoSort->validResult = 0;
    mem++;
    printf("Ciclo detetado!\n");
  }
  // Libertação da memória alocada para a fila
  QueueDestroy(&queue);
  mem++;

  return topoSort;
}



void GraphTopoSortDestroy(GraphTopoSort** p) {
  assert(*p != NULL);

  GraphTopoSort* aux = *p;

  free(aux->marked);
  free(aux->numIncomingEdges);
  free(aux->vertexSequence);

  free(*p);
  *p = NULL;
}

//
// A valid sorting was computed?
//
int GraphTopoSortIsValid(const GraphTopoSort* p) { return p->validResult; }

//
// Getting an array containing the topological sequence of vertex indices
// Or NULL, if no sequence could be computed
// MEMORY IS ALLOCATED FOR THE RESULTING ARRAY
//
unsigned int* GraphTopoSortGetSequence(const GraphTopoSort* p) {
  assert(p != NULL);

  if (!p->validResult) {
    // Se a ordenação topológica não for válida, retorna NULL
    return NULL;
  }

  int numVertices = p->numVertices;

  // Aloca memória para o array que conterá a sequência topológica
  unsigned int* sequence = (unsigned int*)malloc(numVertices * sizeof(unsigned int));
  if (sequence == NULL) {
    // Lidar com falha na alocação de memória
    return NULL;
  }

  // Copia a sequência do struct GraphTopoSort para o array a ser retornado
  for (int i = 0; i < numVertices; ++i) {
    sequence[i] = p->vertexSequence[i];
  }

  return sequence;
}

// DISPLAYING on the console

//
// The toplogical sequence of vertex indices, if it could be computed
//
void GraphTopoSortDisplaySequence(const GraphTopoSort* p) {
  assert(p != NULL);

  if (p->validResult == 0) {
    printf(" *** The topological sorting could not be computed!! *** \n");
    return;
  }

  printf("Topological Sorting - Vertex indices:\n");
  for (unsigned int i = 0; i < GraphGetNumVertices(p->graph); i++) {
    printf("%d ", p->vertexSequence[i]);
  }
  printf("\n");
}

//
// The toplogical sequence of vertex indices, if it could be computed
// Followed by the digraph displayed using the adjecency lists
// Adjacency lists are presented in topologic sorted order
//
void GraphTopoSortDisplay(const GraphTopoSort* p) {
  assert(p != NULL);

  // The topological order
  GraphTopoSortDisplaySequence(p);

  if (p->validResult == 0) {
    return;
  }

  // The Digraph
  for (unsigned int i = 0; i < GraphGetNumVertices(p->graph); i++) {
    GraphListAdjacents(p->graph, p->vertexSequence[i]);
  }
  printf("\n");
}
//
// Algoritmos e Estruturas de Dados --- 2023/2024
//
// Joaquim Madeira, Joao Manuel Rodrigues - June 2021, Nov 2023
//
// Graph - Using a list of adjacency lists representation
//

#include "Graph.h"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#include "SortedList.h"
#include "instrumentation.h"


struct _Vertex {
  unsigned int id;
  unsigned int inDegree;
  unsigned int outDegree;
  List* edgesList;
};

struct _Edge {
  unsigned int adjVertex;
  double weight;
};

struct _GraphHeader {
  int isDigraph;
  int isComplete;
  int isWeighted;
  unsigned int numVertices;
  unsigned int numEdges;
  List* verticesList;
};

// The comparator for the VERTICES LIST

int graphVerticesComparator(const void* p1, const void* p2) {
  unsigned int v1 = ((struct _Vertex*)p1)->id;
  unsigned int v2 = ((struct _Vertex*)p2)->id;
  int d = v1 - v2;
  return (d > 0) - (d < 0);
}

// The comparator for the EDGES LISTS

int graphEdgesComparator(const void* p1, const void* p2) {
  unsigned int v1 = ((struct _Edge*)p1)->adjVertex;
  unsigned int v2 = ((struct _Edge*)p2)->adjVertex;
  int d = v1 - v2;
  return (d > 0) - (d < 0);
}

Graph* GraphCreate(unsigned int numVertices, int isDigraph, int isWeighted) {
  Graph* g = (Graph*)malloc(sizeof(struct _GraphHeader));
  if (g == NULL) abort();

  g->isDigraph = isDigraph;
  g->isComplete = 0;
  g->isWeighted = isWeighted;

  g->numVertices = numVertices;
  g->numEdges = 0;

  g->verticesList = ListCreate(graphVerticesComparator);

  for (unsigned int i = 0; i < numVertices; i++) {
    struct _Vertex* v = (struct _Vertex*)malloc(sizeof(struct _Vertex));
    if (v == NULL) abort();

    v->id = i;
    v->inDegree = 0;
    v->outDegree = 0;

    v->edgesList = ListCreate(graphEdgesComparator);

    ListInsert(g->verticesList, v);
  }

  assert(g->numVertices == ListGetSize(g->verticesList));

  return g;
}

Graph* GraphCreateComplete(unsigned int numVertices, int isDigraph) {
  Graph* g = GraphCreate(numVertices, isDigraph, 0);

  g->isComplete = 1;

  List* vertices = g->verticesList;
  ListMoveToHead(vertices);
  unsigned int i = 0;
  for (; i < g->numVertices; ListMoveToNext(vertices), i++) {
    struct _Vertex* v = ListGetCurrentItem(vertices);
    List* edges = v->edgesList;
    for (unsigned int j = 0; j < g->numVertices; j++) {
      if (i == j) {
        continue;
      }
      struct _Edge* new = (struct _Edge*)malloc(sizeof(struct _Edge));
      if (new == NULL) abort();
      new->adjVertex = j;
      new->weight = 1;

      ListInsert(edges, new);
    }
    if (g->isDigraph) {
      v->inDegree = g->numVertices - 1;
      v->outDegree = g->numVertices - 1;
    } else {
      v->outDegree = g->numVertices - 1;
    }
  }
  if (g->isDigraph) {
    g->numEdges = numVertices * (numVertices - 1);
  } else {
    g->numEdges = numVertices * (numVertices - 1) / 2;
  }

  return g;
}

void GraphDestroy(Graph** p) {
  assert(*p != NULL);
  Graph* g = *p;

  List* vertices = g->verticesList;
  if (ListIsEmpty(vertices) == 0) {
    ListMoveToHead(vertices);
    unsigned int i = 0;
    for (; i < g->numVertices; ListMoveToNext(vertices), i++) {
      struct _Vertex* v = ListGetCurrentItem(vertices);

      List* edges = v->edgesList;
      if (ListIsEmpty(edges) == 0) {
        unsigned int i = 0;
        ListMoveToHead(edges);
        for (; i < ListGetSize(edges); ListMoveToNext(edges), i++) {
          struct _Edge* e = ListGetCurrentItem(edges);
          free(e);
        }
      }
      ListDestroy(&(v->edgesList));
      free(v);
    }
  }

  ListDestroy(&(g->verticesList));
  free(g);

  *p = NULL;
}

Graph* GraphCopy(const Graph* g) {
  assert(g != NULL);

  // Alocar memória para o novo grafo
  Graph* graphCopy = (Graph*)malloc(sizeof(struct _GraphHeader));
  if (graphCopy == NULL) {
    return NULL;
  }

  // Copiar propriedades do grafo
  graphCopy->isDigraph = g->isDigraph;
  graphCopy->isComplete = g->isComplete;
  graphCopy->isWeighted = g->isWeighted;
  graphCopy->numVertices = g->numVertices;
  graphCopy->numEdges = g->numEdges;

  // Alocar e inicializar a nova lista de vértices
  graphCopy->verticesList = ListCreate(graphVerticesComparator);
    
  if (graphCopy->verticesList == NULL) {
    free(graphCopy);
    return NULL;
  }

  // Copiar os vértices e suas listas de adjacências
  ListMoveToHead(g->verticesList);
  for (unsigned int i = 0; i < g->numVertices; i++) {
    struct _Vertex* originalVertex = (struct _Vertex*)ListGetCurrentItem(g->verticesList);
    struct _Vertex* newVertex = (struct _Vertex*)malloc(sizeof(struct _Vertex));
    if (newVertex == NULL) {
      // Libertação de memória em caso de falha
      ListDestroy(&(graphCopy->verticesList));
      free(graphCopy);
      return NULL;
    }

    *newVertex = *originalVertex;
    newVertex->edgesList = ListCreate(graphEdgesComparator);
    if (newVertex->edgesList == NULL) {
      // Libertação de memória em caso de falha
      free(newVertex);
      ListDestroy(&(graphCopy->verticesList));
      free(graphCopy);
      return NULL;
    }

    ListMoveToHead(originalVertex->edgesList);
    for (unsigned int j = 0; j < originalVertex->outDegree; j++) {
      struct _Edge* originalEdge = (struct _Edge*)ListGetCurrentItem(originalVertex->edgesList);
      struct _Edge* newEdge = (struct _Edge*)malloc(sizeof(struct _Edge));

      if (newEdge == NULL) {
        // Libertação de memória em caso de falha
        ListDestroy(&(newVertex->edgesList));
        free(newVertex);
        ListDestroy(&(graphCopy->verticesList));
        free(graphCopy);
        return NULL;
      }
      *newEdge = *originalEdge;
      ListInsert(newVertex->edgesList, newEdge);
      ListMoveToNext(originalVertex->edgesList);
    }
    ListInsert(graphCopy->verticesList, newVertex);
    ListMoveToNext(g->verticesList);
  }
  return graphCopy;
}

/* struct _GraphHeader {
  int isDigraph;
  int isComplete;
  int isWeighted;
  unsigned int numVertices;
  unsigned int numEdges;
  List* verticesList;
};*/

Graph* GraphFromFile(FILE* f) {
  assert(f != NULL);

  //0 / 1 É grafo orientado ?
  //0 / 1 Há pesos associados às arestas ?
  //Número de vértices
  //Número de arestas
  // ler os parametros do grafo que estão no ficheiro (primeira, segunda, terceira e quarta linha)
  unsigned int numVertices, numEdges, isDigraph, isWeighted;
  fscanf(f, "%u\n%u\n%u\n%u\n", &isDigraph, &isWeighted, &numVertices, &numEdges);
  printf("isDigraph: %d\nisWeighted: %d\nnumVertices: %d\nnumEdges: %d\n", isDigraph, isWeighted, numVertices, numEdges);
  
  // criar o grafo
  Graph* graph = GraphCreate(numVertices, isDigraph, isWeighted);
  if (graph == NULL)
  {
    printf("Erro ao criar o grafo!\n");
  }
  

  while (!feof(f))
  {
    // caso o grafo seja ordenado (1) ler o peso da aresta
    if (isWeighted == 1) {
      int vertex;
      int edges;
      double weight;
      fscanf(f, "%d %d %lf\n", &vertex, &edges, &weight);
      //printf("vertex: %d\nedges: %d\nweight: %lf\n", vertex, edges, weight);
      GraphAddWeightedEdge(graph, vertex, edges, weight);
    }

    else {
      // caso o grafo não seja ordenado (0) ler apenas as duas colunas existentes
      int vertex;
      int edges;
      fscanf(f, "%d %d\n", &vertex, &edges);
      //printf("vertex: %d\nedges: %d\n", vertex, edges);
      GraphAddEdge(graph, vertex, edges);
    }
  }
  return graph;
}


// Graph

int GraphIsDigraph(const Graph* g) { return g->isDigraph; }

int GraphIsComplete(const Graph* g) { return g->isComplete; }

int GraphIsWeighted(const Graph* g) { return g->isWeighted; }

unsigned int GraphGetNumVertices(const Graph* g) { return g->numVertices; }

unsigned int GraphGetNumEdges(const Graph* g) { return g->numEdges; }

//
// For a graph
//
double GraphGetAverageDegree(const Graph* g) {
  assert(g->isDigraph == 0);
  return 2.0 * (double)g->numEdges / (double)g->numVertices;
}

static unsigned int _GetMaxDegree(const Graph* g) {
  List* vertices = g->verticesList;
  if (ListIsEmpty(vertices)) return 0;

  unsigned int maxDegree = 0;
  ListMoveToHead(vertices);
  unsigned int i = 0;
  for (; i < g->numVertices; ListMoveToNext(vertices), i++) {
    struct _Vertex* v = ListGetCurrentItem(vertices);
    if (v->outDegree > maxDegree) {
      maxDegree = v->outDegree;
    }
  }
  return maxDegree;
}

//
// For a graph
//
unsigned int GraphGetMaxDegree(const Graph* g) {
  assert(g->isDigraph == 0);
  return _GetMaxDegree(g);
}

//
// For a digraph
//
unsigned int GraphGetMaxOutDegree(const Graph* g) {
  assert(g->isDigraph == 1);
  return _GetMaxDegree(g);
}

// Vertices

//
// returns an array of size (outDegree + 1)
// element 0, stores the number of adjacent vertices
// and is followed by indices of the adjacent vertices
//
unsigned int* GraphGetAdjacentsTo(const Graph* g, unsigned int v) {
  assert(v < g->numVertices);

  // Node in the list of vertices
  List* vertices = g->verticesList;
  ListMove(vertices, v);
  struct _Vertex* vPointer = ListGetCurrentItem(vertices);
  unsigned int numAdjVertices = vPointer->outDegree;

  unsigned int* adjacent =
      (unsigned int*)calloc(1 + numAdjVertices, sizeof(unsigned int));

  if (numAdjVertices > 0) {
    adjacent[0] = numAdjVertices;
    List* adjList = vPointer->edgesList;
    ListMoveToHead(adjList);
    for (unsigned int i = 0; i < numAdjVertices; ListMoveToNext(adjList), i++) {
      struct _Edge* ePointer = ListGetCurrentItem(adjList);
      adjacent[i + 1] = ePointer->adjVertex;
    }
  }

  return adjacent;
}

//
// returns an array of size (outDegree + 1)
// element 0, stores the number of adjacent vertices
// and is followed by the distances to the adjacent vertices
//
double* GraphGetDistancesToAdjacents(const Graph* g, unsigned int v) {
  assert(v < g->numVertices);

  // Node in the list of vertices
  List* vertices = g->verticesList;
  ListMove(vertices, v);
  struct _Vertex* vPointer = ListGetCurrentItem(vertices);
  unsigned int numAdjVertices = vPointer->outDegree;

  double* distance = (double*)calloc(1 + numAdjVertices, sizeof(double));

  if (numAdjVertices > 0) {
    distance[0] = numAdjVertices;
    List* adjList = vPointer->edgesList;
    ListMoveToHead(adjList);
    for (unsigned int i = 0; i < numAdjVertices; ListMoveToNext(adjList), i++) {
      struct _Edge* ePointer = ListGetCurrentItem(adjList);
      distance[i + 1] = ePointer->weight;
    }
  }

  return distance;
}

//
// For a graph
//
unsigned int GraphGetVertexDegree(Graph* g, unsigned int v) {
  assert(g->isDigraph == 0);
  assert(v < g->numVertices);

  ListMove(g->verticesList, v);
  struct _Vertex* p = ListGetCurrentItem(g->verticesList);

  return p->outDegree;
}

//
// For a digraph
//
unsigned int GraphGetVertexOutDegree(Graph* g, unsigned int v) {
  assert(g->isDigraph == 1);
  assert(v < g->numVertices);

  ListMove(g->verticesList, v);
  struct _Vertex* p = ListGetCurrentItem(g->verticesList);

  return p->outDegree;
}

//
// For a digraph
//
unsigned int GraphGetVertexInDegree(Graph* g, unsigned int v) {
  assert(g->isDigraph == 1);
  assert(v < g->numVertices);

  ListMove(g->verticesList, v);
  struct _Vertex* p = ListGetCurrentItem(g->verticesList);

  return p->inDegree;
}

// Edges

static int _addEdge(Graph* g, unsigned int v, unsigned int w, double weight) {
  struct _Edge* edge = (struct _Edge*)malloc(sizeof(struct _Edge));
  edge->adjVertex = w;
  edge->weight = weight;

  ListMove(g->verticesList, v);
  struct _Vertex* vertex = ListGetCurrentItem(g->verticesList);
  int result = ListInsert(vertex->edgesList, edge);

  if (result == -1) {
    return 0;
  } else {
    g->numEdges++;
    vertex->outDegree++;

    ListMove(g->verticesList, w);
    struct _Vertex* destVertex = ListGetCurrentItem(g->verticesList);
    destVertex->inDegree++;
  }

  if (g->isDigraph == 0) {
    // Bidirectional edge
    struct _Edge* edge = (struct _Edge*)malloc(sizeof(struct _Edge));
    edge->adjVertex = v;
    edge->weight = weight;

    ListMove(g->verticesList, w);
    struct _Vertex* vertex = ListGetCurrentItem(g->verticesList);
    result = ListInsert(vertex->edgesList, edge);

    if (result == -1) {
      return 0;
    } else {
      // g->numEdges++; // Do not count the same edge twice on a undirected
      // graph !!
      vertex->outDegree++;
    }
  }

  return 1;
}

int GraphAddEdge(Graph* g, unsigned int v, unsigned int w) {
  assert(g->isWeighted == 0);
  assert(v != w);
  assert(v < g->numVertices);
  assert(w < g->numVertices);

  return _addEdge(g, v, w, 1.0);
}

int GraphAddWeightedEdge(Graph* g, unsigned int v, unsigned int w,
                         double weight) {
  assert(g->isWeighted == 1);
  assert(v != w);
  assert(v < g->numVertices);
  assert(w < g->numVertices);

  return _addEdge(g, v, w, weight);
}

int GraphRemoveEdge(Graph* g, unsigned int v, unsigned int w) {
  assert(g != NULL && v < g->numVertices && w < g->numVertices);

  List* vertices_List = g->verticesList;
  ListMove(vertices_List, v);

  struct _Vertex* vertex = ListGetCurrentItem(vertices_List);
  List* edges_List = vertex->edgesList;

  ListMoveToHead(edges_List);

  for (unsigned int i = 0; i < ListGetSize(edges_List); ListMoveToNext(edges_List), i++) {
    struct _Edge* edge = ListGetCurrentItem(edges_List);

    if (edge->adjVertex == w) {
      ListRemoveCurrent(edges_List);
      vertex->outDegree--;
      g->numEdges--;

      ListMove(vertices_List, w);
      struct _Vertex* adjVertex = ListGetCurrentItem(vertices_List);
      adjVertex->inDegree--;

      if (g->isDigraph == 0) {
        List* adjEdge_List = adjVertex->edgesList;
        ListMoveToHead(adjEdge_List);
        for (unsigned int j = 0; j < ListGetSize(adjEdge_List); ListMoveToNext(adjEdge_List), j++) {
          struct _Edge* adjEdge = ListGetCurrentItem(adjEdge_List);
          if (adjEdge->adjVertex == v) {
            ListRemoveCurrent(adjEdge_List);
            adjVertex->outDegree--;
            vertex->inDegree--;
            break;
          }
        }
      }
      //g->numEdges--;
      return 1;
    }
  }

  return 0;
}


// CHECKING

int GraphCheckInvariants(const Graph* g) {
  assert(g != NULL);

  // Verificar se o número de vértices e arestas está correto
  if (g->numVertices != ListGetSize(g->verticesList)) {
    fprintf(stderr, "Número de vértices incorreto!\n");
    return 0;
  }

  // Verificar se o grafo é direcionado ou não direcionado
  if (g->isDigraph && g->numEdges != GraphGetNumEdges(g)) {
    fprintf(stderr, "Grafo direcionado com contagem de arestas incorreta!\n");
    return 0;
  }

  // Verificar se o grafo é completo
  if (g->isComplete) {
    unsigned int expectedEdges = 0;

    if (g->isDigraph) {
      expectedEdges = g->numVertices * (g->numVertices - 1);
    } else {
      unsigned int nonDirectedEdges = g->numVertices - 1;
      expectedEdges = nonDirectedEdges * (g->numVertices - 1) / 2;
    }

    if (g->numEdges != expectedEdges) {
      fprintf(stderr, "Contagem incorreta de arestas para grafo completo!\n");
      return 0;
      }
  }
  return 1;  // Todas as verificações passaram
}


// DISPLAYING on the console

void GraphDisplay(const Graph* g) {
  printf("---\n");
  if (g->isWeighted) {
    printf("Weighted ");
  }
  if (g->isComplete) {
    printf("COMPLETE ");
  }
  if (g->isDigraph) {
    printf("Digraph\n");
    printf("Max Out-Degree = %d\n", GraphGetMaxOutDegree(g));
  } else {
    printf("Graph\n");
    printf("Max Degree = %d\n", GraphGetMaxDegree(g));
  }
  printf("Vertices = %2d | Edges = %2d\n", g->numVertices, g->numEdges);

  List* vertices = g->verticesList;
  ListMoveToHead(vertices);
  unsigned int i = 0;
  for (; i < g->numVertices; ListMoveToNext(vertices), i++) {
    printf("%2d ->", i);
    struct _Vertex* v = ListGetCurrentItem(vertices);
    if (ListIsEmpty(v->edgesList)) {
      printf("\n");
    } else {
      List* edges = v->edgesList;
      unsigned int i = 0;
      ListMoveToHead(edges);
      for (; i < ListGetSize(edges); ListMoveToNext(edges), i++) {
        struct _Edge* e = ListGetCurrentItem(edges);
        if (g->isWeighted) {
          printf("   %2d(%4.2f)", e->adjVertex, e->weight);
        } else {
          printf("   %2d", e->adjVertex);
        }
      }
      printf("\n");
    }
  }
  printf("---\n");
}

void GraphListAdjacents(const Graph* g, unsigned int v) {
  printf("---\n");

  unsigned int* array = GraphGetAdjacentsTo(g, v);

  printf("Vertex %d has %d adjacent vertices -> ", v, array[0]);

  for (unsigned int i = 1; i <= array[0]; i++) {
    printf("%d ", array[i]);
  }

  printf("\n");

  free(array);

  printf("---\n");
}
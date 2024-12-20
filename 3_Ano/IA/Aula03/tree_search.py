
# Module: tree_search
# 
# This module provides a set o classes for automated
# problem solving through tree search:
#    SearchDomain  - problem domains
#    SearchProblem - concrete problems to be solved
#    SearchNode    - search tree nodes
#    SearchTree    - search tree with the necessary methods for searhing
#
#  (c) Luis Seabra Lopes
#  Introducao a Inteligencia Artificial, 2012-2020,
#  Inteligência Artificial, 2014-2023

from abc import ABC, abstractmethod

# Dominios de pesquisa
# Permitem calcular
# as accoes possiveis em cada estado, etc
class SearchDomain(ABC):

    # construtor
    @abstractmethod
    def __init__(self):
        pass

    # lista de accoes possiveis num estado
    @abstractmethod
    def actions(self, state):
        pass

    # resultado de uma accao num estado, ou seja, o estado seguinte
    @abstractmethod
    def result(self, state, action):
        pass

    # custo de uma accao num estado
    @abstractmethod
    def cost(self, state, action):
        pass

    # custo estimado de chegar de um estado a outro
    @abstractmethod
    def heuristic(self, state, goal):
        pass

    # test if the given "goal" is satisfied in "state"
    @abstractmethod
    def satisfies(self, state, goal):
        pass


# Problemas concretos a resolver
# dentro de um determinado dominio
class SearchProblem:
    def __init__(self, domain, initial, goal):
        self.domain = domain
        self.initial = initial
        self.goal = goal
        
    def goal_test(self, state):
        return self.domain.satisfies(state,self.goal)

# Nos de uma arvore de pesquisa
class SearchNode:
    def __init__(self,state,parent,depth): 
        self.state = state
        self.parent = parent
    # ex2 -----
        self.depth = depth
    # ----------
    # ex1 ------
    def in_parent(self,newstate):
        if self.parent == None:
            return False #se o nó atual não tem pai, é a raiz
        if self.state == newstate:
            return True
        return self.parent.in_parent(newstate)
    # ---

    def __str__(self):
        return "no(" + str(self.state) + "," + str(self.parent) + ")"
    def __repr__(self):
        return str(self)

# Arvores de pesquisa
class SearchTree:

    # construtor
    def __init__(self,problem, strategy='depth'): 
        self.problem = problem
        root = SearchNode(problem.initial, None,0)
        self.open_nodes = [root]
        self.strategy = strategy
        self.solution = None
        # ex5 -----
        self.terminals = 0 # nó terminal (folha)
        self.non_terminals = 0 # nó não terminal
        # ----------
    # ex3
    @property
    def length(self):
        if self.solution == None:
            return 0
        else:
            return self.solution.depth
        
    @property
    def avg_branching(self):
        # Total de nós filhos (exceto a raiz)/ nós pai
        return (self.terminals + self.non_terminals - 1 ) / self.non_terminals
    # obter o caminho (sequencia de estados) da raiz ate um no
    def get_path(self,node):
        if node.parent == None:
            return [node.state]
        path = self.get_path(node.parent)
        path += [node.state]
        return(path)

    # procurar a solucao
    def search(self, limit = None):

        while self.open_nodes != []:

            node = self.open_nodes.pop(0)

            self.terminals = len(self.open_nodes)
            
            if self.problem.goal_test(node.state):
                self.solution = node
                return self.get_path(node)
            lnewnodes = []
            self.non_terminals += 1
            # ex4 --------
            if limit is not None and node.depth >= limit:
                continue # avançar os nós que excedem o limite de profundidade
            # ------------
            for a in self.problem.domain.actions(node.state):
                newstate = self.problem.domain.result(node.state,a)
                
                # verificação para verificar se nó já foi visitado
                if not node.in_parent(newstate):
                    newnode = SearchNode(newstate,node, node.depth + 1)
                    lnewnodes.append(newnode)

            self.add_to_open(lnewnodes)

        return None

    # juntar novos nos a lista de nos abertos de acordo com a estrategia
    def add_to_open(self,lnewnodes):
        if self.strategy == 'breadth':
            self.open_nodes.extend(lnewnodes)
        elif self.strategy == 'depth':
            self.open_nodes[:0] = lnewnodes
        elif self.strategy == 'uniform':
            pass

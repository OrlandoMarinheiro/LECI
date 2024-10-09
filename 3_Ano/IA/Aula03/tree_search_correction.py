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
#  InteligÃªncia Artificial, 2014-2023

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
        a1,a2 = action
        assert state == a1
        for (c1,c2,d) in self.connections:
            if (c1,c2) == action or (c2,c1) == action:
                return d
        return None


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
    def __init__(self,state,parent,cost,heuristic,depth): 
        self.state = state
        self.parent = parent
        self.depth = depth     
        self.cost = cost 
        self.heuristic = heuristic                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
    def in_parent(self,newstate):
        if self.parent == None:
            return False
        if self.parent.state == newstate:
            return True
        return self.parent.in_parent(newstate)
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
    @property
    def lengh(self): #ex3
        return self.solution.depth 
    @property
    def avg_branching(self):
        return (self.terminal + self.non_terminal - 1 )/self.non_terminals
    @property
    def cost(self):
        return self.solution.cost

    # obter o caminho (sequencia de estados) da raiz ate um no
    def get_path(self,node):
        if node.parent == None:
            return [node.state]
        path = self.get_path(node.parent)
        path += [node.state]                                                                                                                                                            
        return(path)

    # procurar a solucao
    def search(self, limit = None):
        acum_depth = 0
        while self.open_nodes != []:
            node = self.open_nodes.pop(0)
            acum_depth += 1
            if self.problem.goal_test(node.state):
                self.plan = self.get_plan(node)
                self.solution = node
                self.terminals = len(self.opne_nodes) +1
                self.average_depth = acum_depth/(self.terminals + self.non_terminals)
                return self.get_path(node)
                
            if limit is not None and node.depth >= limit: #ex4
                continue

            lnewnodes = []
            for a in self.problem.domain.actions(node.state):
                newstate = self.problem.domain.result(node.state,a)
                if newstate not in lnewnodes:  #ex1
                    ct = self.problem.domain.cost(node.state,a)
                    #h = self.problem.heuristic(newstate,self.problem.goal)
                    newnode =  SearchNode(newstate,node,node.depth + 1, node.cost+ct,h)
                    lnewnodes.append(newnode)
            #print(acum_depth) 
            self.add_to_open(lnewnodes)
            acum_depth += 1

        return None

    # juntar novos nos a lista de nos abertos de acordo com a estrategia
    def add_to_open(self,lnewnodes):
        if self.strategy == 'breadth':
            self.open_nodes.extend(lnewnodes)
        elif self.strategy == 'depth':
            self.open_nodes[:0] = lnewnodes
        elif self.strategy == 'uniform':
            self.open_nodes.extend(lnewnodes)
            self.open_nodes.sort(key=lambda node: node.cost)


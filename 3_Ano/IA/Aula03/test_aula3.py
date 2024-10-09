from cidades import SearchProblem, SearchTree, cidades_portugal

def braga_faro():
    return SearchProblem(cidades_portugal,'Braga','Faro')

#----------1

t = SearchTree(braga_faro,'depth')

assert t.search() == ['Braga', 'Porto', 'Agueda', 'Aveiro', 'Coimbra', 'Leiria', 'Castelo Branco', 'Santarem', 'Lisboa', 'Evora', 'Beja', 'Faro']

#----------2

t = SearchTree(braga_faro, 'depth')

assert t.open_nodes[-1].depth == 0
t.search()
assert t.solution.depth == 11


#----------3

t = SearchTree(braga_faro, 'depth')

t.search()

assert t.length == 11


#----------4

t = SearchTree(braga_faro, 'depth')

assert t.search(limit=9) == ['Braga', 'Porto', 'Agueda', 'Aveiro', 'Coimbra', 'Leiria', 'Santarem', 'Lisboa', 'Beja', 'Faro']

assert t.length <= 9


#----------5

t = SearchTree(braga_faro, 'depth')

assert t.search() == ['Braga', 'Porto', 'Agueda', 'Aveiro', 'Coimbra', 'Leiria', 'Castelo Branco', 'Santarem', 'Lisboa', 'Evora', 'Beja', 'Faro']
assert t.terminals == 19
assert t.non_terminals == 11

t = SearchTree(braga_faro, 'depth')

assert t.search(limit=9) == ['Braga', 'Porto', 'Agueda', 'Aveiro', 'Coimbra', 'Leiria', 'Santarem', 'Lisboa', 'Beja', 'Faro']
assert t.terminals == 12
assert t.non_terminals == 58 

#----------6


t = SearchTree(braga_faro, 'depth')

assert t.search() == ['Braga', 'Porto', 'Agueda', 'Aveiro', 'Coimbra', 'Leiria', 'Castelo Branco', 'Santarem', 'Lisboa', 'Evora', 'Beja', 'Faro']
assert round(t.avg_branching,2) == round((19+11-1)/11,2)

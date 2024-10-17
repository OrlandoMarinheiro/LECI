from cidades import SearchProblem, SearchTree, cidades_portugal


def braga_faro():
    return SearchProblem(cidades_portugal, 'Braga', 'Faro')

def test_exercicio1():
    t = SearchTree(braga_faro(), 'depth')

    assert t.search() == ['Braga', 'Porto', 'Agueda', 'Aveiro', 'Coimbra', 'Leiria', 'Castelo Branco', 'Santarem', 'Lisboa', 'Evora', 'Beja', 'Faro']

test_exercicio1()

def test_exercicio2():
    t = SearchTree(braga_faro(), 'depth')

    assert t.open_nodes[-1].depth == 0
    t.search()
    assert t.solution.depth == 11

test_exercicio2()

def test_exercicio3():
    t = SearchTree(braga_faro(), 'depth')

    t.search()

    assert t.length == 11

test_exercicio3()

def test_exercicio4():
    t = SearchTree(braga_faro(), 'depth')

    assert t.search(limit=9) == ['Braga', 'Porto', 'Agueda', 'Aveiro', 'Coimbra', 'Leiria', 'Santarem', 'Lisboa', 'Beja', 'Faro']

    assert t.length <= 9

test_exercicio4()

def test_exercicio5():
    t = SearchTree(braga_faro(), 'depth')

    assert t.search() == ['Braga', 'Porto', 'Agueda', 'Aveiro', 'Coimbra', 'Leiria', 'Castelo Branco', 'Santarem', 'Lisboa', 'Evora', 'Beja', 'Faro']
    assert t.terminals == 19
    assert t.non_terminals == 11

    t = SearchTree(braga_faro(), 'depth')

    assert t.search(limit=9) == ['Braga', 'Porto', 'Agueda', 'Aveiro', 'Coimbra', 'Leiria', 'Santarem', 'Lisboa', 'Beja', 'Faro']
    assert t.terminals == 12
    assert t.non_terminals == 58

test_exercicio5()

def test_exercicio6():
    t = SearchTree(braga_faro(), 'depth')

    assert t.search() == ['Braga', 'Porto', 'Agueda', 'Aveiro', 'Coimbra', 'Leiria', 'Castelo Branco', 'Santarem', 'Lisboa', 'Evora', 'Beja', 'Faro']
    assert round(t.avg_branching, 2) == round((19 + 11 - 1) / 11, 2)

test_exercicio6()

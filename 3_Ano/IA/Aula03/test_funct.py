import pytest
from cidades import SearchProblem, SearchTree, cidades_portugal

def test_exercicio7(braga_faro):
    print(cidades_portugal.cost('Aveiro', ('Aveiro', 'Agueda')))
    print("assert cidades")
    assert cidades_portugal.cost('Agueda', ('Agueda', 'Aveiro')) == 35
    assert cidades_portugal.cost('Aveiro', ('Aveiro', 'Lisboa')) == None 
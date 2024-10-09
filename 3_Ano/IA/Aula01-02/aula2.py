import math
from aula1 import *

#teste
def par(x):
    if x % 2 == 0:
        return True
    return False

f = lambda x, y: x < y

#Exercicio 4.1
impar = lambda x: x % 2 != 0

#Exercicio 4.2
positivo = lambda x: x > 0

#Exercicio 4.3
comparar_modulo = lambda x, y: math.fabs(x) < math.fabs(y)

#Exercicio 4.4 
cart2pol = lambda x,y: (math.sqrt((x**2 + y**2)), math.atan2(y,x))

#Exercicio 4.5
ex5 = lambda f, g, h: lambda x, y, z: h(f(x,y), g(y,z))

#Exercicio 4.6
def quantificador_universal(lista, f):
    return all(f(x) for x in lista)

#Exercicio 4.7
def quantificador_existencial(lista, f):
    if f(lista[0]):
        return True 
    return quantificador_existencial(lista[1:], f)
 
#Exercicio 4.8
def subconj(lista1, lista2):
    return all(x in lista2 for x in lista1)

def subconjunto(lista1, lista2):
<<<<<<< HEAD
    if lista1 == []: #todo o conjunto vazio está inserido num outro conjunto
        return True
    if lista2 == []:
        return True
    
    if lista1[0] in lista2:
        return True and subconjunto(lista1[1:], lista2)
    return False


=======
    
    return 
>>>>>>> origin/main

#Exercicio 4.9
def menor_ordem(lista, f):
    if comprimento(lista) == 1:
        return lista[0]

    m = menor_ordem(lista[1:], f)
    if f(lista[0], m):
        return lista[0]
    return m

#Exercicio 4.10 
def menor_e_resto_ordem(lista, f):
    if comprimento(lista) == 1:
        return lista[0], []
    
    m, resto = menor_e_resto_ordem(lista[1:], f)

    if f(lista[0], m):
        return lista[0], lista[1:]
    else:
        return m, [lista[0]] + resto


#Exercicio 5.2 
def ordenar_seleccao(lista, ordem):
    if lista == []:
        return []

    resto = ordenar_seleccao(lista[1:], ordem) 
    if resto:
        if ordem(lista[0], resto[0]):
            return [lista[0]] + resto
        else:
            for i in range(comprimento(resto)):
                if ordem(lista[0], resto[i]):
                    return resto[:i] + [lista[0]] + resto[i:]
            return resto + [lista[0]]
    return [lista[0]]

def main():
    print("## Exercicio 4.1 ##")
    print(impar(3))
    print(impar(4))

    print("\n## Exercicio 4.2 ##")
    print(positivo(-1))
    print(positivo(2))

    print("\n## Exercicio 4.3 ##")
    print(comparar_modulo(-4,2))
    print(comparar_modulo(5,2))

    print("\n## Exercicio 4.4 ##")
    print(cart2pol(3,4))

    print("\n## Exercicio 4.7 ##")
    print(quantificador_existencial([1,2,3,5,7], par))

    print("\n## Exercicio 4.8 ##")
    print(subconjunto([1,2,3,4], [4,3,2,1]))
    print(subconjunto([1,2,3,4], [4,5,6,1]))

    print("\n## Exercicio 4.9 ##")
    print(menor_ordem([1,-1,4,0], f))

    print("\n## Exercicio 4.10 ##")
    print(menor_e_resto_ordem([1,-1,4,0], f))

    print("\n## Exercicio 5.2 ##")
    print(ordenar_seleccao([3,4,1,2], f))
    
if __name__ == "__main__":
    main()

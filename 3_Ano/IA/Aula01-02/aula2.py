import math

#Exercicio 4.1
impar = lambda x: x % 2 != 0

#Exercicio 4.2
positivo = lambda x: x > 0

#Exercicio 4.3
comparar_modulo = lambda x, y: math.fabs(x) < math.fabs(y)

#Exercicio 4.4 #duvida: posso usar biblioteca math
cart2pol = lambda x,y: (math.sqrt((x**2 + y**2)), math.atan2(y,x))

#Exercicio 4.5
ex5 = lambda f, g, h: lambda x, y, z: h(f(x,y), g(y,z))

#Exercicio 4.6
def quantificador_universal(lista, f):
    return all(f(x) for x in lista)

#Exercicio 4.8
def subconjunto(lista1, lista2):
    return all(x in lista2 for x in lista1)

#Exercicio 4.9 duvida
def menor_ordem(lista, f):
    return min(lista, key=f)

#Exercicio 4.10 duvida
def menor_e_resto_ordem(lista, f):
    menor = min(lista, key=f)
    restante = [x for x in lista if x != menor]
    return menor, restante

#Exercicio 5.2 duvida
def ordenar_seleccao(lista, ordem):
    pass

def main():
    print(impar(3))
    print(impar(4))
    print("############")
    print(positivo(-1))
    print(positivo(2))
    print("############")
    print(comparar_modulo(-4,2))
    print(comparar_modulo(5,2))
    print("############")
    print(cart2pol(3,4))
    print("############")
    print(subconjunto([1,2,3,4], [4,3,2,1]))
    print(subconjunto([1,2,3,4], [4,5,6,1]))
    
if __name__ == "__main__":
    main()

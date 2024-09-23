import math

#Exercicio 4.1
impar = lambda x: x % 2 != 0

#Exercicio 4.2
positivo = lambda x: x > 0

#Exercicio 4.3
comparar_modulo = lambda x, y: x < y

#Exercicio 4.4 #duvida: posso usar biblioteca math
cart2pol = lambda x,y: (math.sqrt((x**2 + y**2)), math.atan2(y,x))

#Exercicio 4.5
ex5 = lambda f, g, h: lambda x, y, z: h(f(x,y), g(y,z))

#Exercicio 4.6
def quantificador_universal(lista, f):
    return all(f(x) for x in lista)

#Exercicio 4.8
def subconjunto(lista1, lista2):
    pass

#Exercicio 4.9
def menor_ordem(lista, f):
    pass

#Exercicio 4.10
def menor_e_resto_ordem(lista, f):
    pass

#Exercicio 5.2
def ordenar_seleccao(lista, ordem):
    pass

def main():
    print(impar(3))
    print(impar(4))
    print("############")
    print(positivo(-1))
    print(positivo(2))
    print("############")
    print(comparar_modulo(2,5))
    print(comparar_modulo(5,2))
    print("############")
    print(cart2pol(3,4))
    print("############")
    
if __name__ == "__main__":
    main()

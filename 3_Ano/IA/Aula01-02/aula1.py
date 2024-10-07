#Exercicio 1.1
def comprimento(lista):
	if not lista:
		return 0
	return 1 + comprimento(lista[1:])

#Exercicio 1.2
def soma(lista):
	if not lista:
		return 0
	return lista[0] + soma(lista[1:])

#Exercicio 1.3
def existe(lista, elem):
	if not lista:
		return False
	if elem == lista[0]:
		return True
	return existe(lista[1:], elem)


#Exercicio 1.4 
def concat(l1, l2):
	if not l1:
		return l2
	if not l2:
		return l1
	return [l1[0]] + concat(l1[1:], l2)

#Exercicio 1.5
def inverte(lista):
	if lista == []:
		return []
	lista_invertida = inverte(lista[1:])
	lista_invertida[comprimento(lista_invertida):] = [lista[0]]
	return lista_invertida

#Exercicio 1.6
def capicua(lista):
	if not lista:
		return False
	if comprimento(lista) == 1:
		return True
	
	if lista[0] == lista[-1]:
		sublista_sem_extremos = capicua(lista[1:-1])
		return True
	else:
		return False

#Exercicio 1.7
def concat_listas(lista):
	if lista[:] == []:
		return []
	return lista[0] + concat_listas(lista[1:])

#Exercicio 1.8
def substitui(lista, original, novo):
	if lista == []:
		return []
	subst_lista = substitui(lista[1:],original,novo)

	if lista[0] == original:
		#print([novo] + subst_lista)
		return [novo] + subst_lista
	#print([lista[0]] + subst_lista)
	return [lista[0]] + subst_lista

#Exercicio 1.9
def fusao_ordenada(lista1, lista2):
	if not lista1:
		return lista2
	if not lista2:
		return lista1

	if lista1[0] < lista2[0]:
		return [lista1[0]] + fusao_ordenada(lista1[1:], lista2)
	else:
		return [lista2[0]] + fusao_ordenada(lista1, lista2[1:])
		

#Exercicio 1.10
def lista_subconjuntos(lista): # lista = [1, 2, 3]
	if lista == []:
		return [[]]
	
	subconjunto_sem_primeiro = lista_subconjuntos(lista[1:])   # [2, 3] [3]
	
	subconjunto_com_primeiro = [[lista[0]] + subconjunto for subconjunto in subconjunto_sem_primeiro]
	
	
	return subconjunto_sem_primeiro + subconjunto_com_primeiro
#Exercicio 2.1
def separar(lista):
	if lista == []:
		return ([],[])
	a, b = lista[0]
	primeiros, segundos = separar(lista[1:])

	return [a] + primeiros, [b] + segundos


#Exercicio 2.2
def remove_e_conta(lista, elem):
	if not lista:
		return [],0
	
	if lista[0] == elem:
		lista_restante, cnt = remove_e_conta(lista[1:], elem)
		return lista_restante, cnt + 1
	else:
		lista_restante, cnt = remove_e_conta(lista[1:], elem)
		return [lista[0]] + lista_restante, cnt


#Exercicio 3.1
def cabeca(lista):
	if not lista:
		return None
	else:
		return lista[0]

#Exercicio 3.2
def cauda(lista):
	if not lista:
		return None
	else:
		return lista[1:]


#Exercicio 3.3
def juntar(l1, l2):
	if comprimento(l1) != comprimento(l2):
		return None
	if not l1:
		return []
	if not l2:
		return []
	
	primeiro_par = l1[0], l2[0]
	pares_restantes = juntar(l1[1:], l2[1:])
	return [primeiro_par] + pares_restantes

#Exercicio 3.4
def menor(lista):
	if not lista:
		return None
	if comprimento(lista) == 1:
		return lista[0]
	
	menor_numero = menor(lista[1:])

	if lista[0] < menor_numero:
		return lista[0]
	else:
		return menor_numero

#Exercicio 3.6
def max_min(lista):

	if not lista:
		return None

	if comprimento(lista) == 1:
		return lista[0], lista[0]
	
	maior_numero, menor_numero = max_min(lista[1:])

	if lista[0] > maior_numero:
		maior_numero = lista[0]

	if lista[0] < menor_numero:
		menor_numero = lista[0]

	return maior_numero, menor_numero

'''def main():
	print(capicua([1,3,2]))
	print(concat([], []))
	print(concat_listas([[1,2],[5,4],[9,4]]))
	print(concat_listas([[],[5,4],[9,4]]))
	print(substitui([1,2,3,4,3,5,3], 3, 7))
	print(fusao_ordenada([1,4,7], [2,3]))
	print(lista_subconjuntos([1,2,3]))
	print(separar([(1,2),(2,5),(4,7)]))
	print(remove_e_conta([1,2,2,3,3,4], 2))
	print(juntar([1,2,3], ['a','b','c']))
	print(menor([3,5,1,2]))
	print(max_min([3,1,5,9,2,6]))
if __name__ == "__main__":
    main()
'''


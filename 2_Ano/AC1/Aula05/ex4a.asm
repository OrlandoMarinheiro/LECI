	.data
lista:	.space 40
	.align 2
str1:	.asciiz "\nIntroduza um valor: "
str2:	.asciiz "; "
str3: 	.asciiz "Conteudo do array:\n"
	.eqv FALSE,0
	.eqv TRUE,1
	.eqv SIZE,10
	.eqv print_int10,1
	.eqv read_int,5
	.eqv print_string,4
	.text
	.globl main
main:
#$t0 -> lista $t1 -> SIZE
#t4 -> houvetroca; $t5 -> p; $t6 -> pUltimo
	la $t5,lista		#	p = 0;	# iniciar a lista, p contem o endereço do primeiro elemento da lista	
	li $t1,SIZE		#	tamanho da lista	
	li $t0,1
	subu $t1,$t1,$t0
	mul $t1,$t1,4		# tornar multiplo de 4 para chegar ao ultimo elemento
	addu $t6,$t5,$t1	#	pUltimo = lista + (SIZE - 1) -> ultimo elemento da lista
for1:	
	bge $t5,$t6,endfor1	# p <= pultimo
	li $v0,read_int
	syscall
	sw $v0,0($t5)		# posição atual obtem valor do input
	addiu $t5,$t5,4		#p++
	j	for1
endfor1:
do:	
	li $t4,FALSE		# houvetroca = FALSE
	la $t5,lista		#	p = lista
for2:
	bge $t5,$t6,endfor2	#	p < pultumo
	lw $t7,0($t5)		#	carregar o endereço de p para *p
	lw $t8,4($t5)		#	carregar o endereço de p para *(p+1)
if:	
	ble $t7,$t8,endif	#	*p > *(p+1)
	move $t9,$t7		#	aux = *p
	sw $t8,0($t5)		# *p = *(p+1)
	sw $t9,4($t5)		# *(p+1) = aux
	li $t4,TRUE		# houvetroca == true
endif:
	addi $t5,$t5,4		# p++
	j	for2
endfor2:
while:
	beq $t4,TRUE,do		# if(houvetroca == true)
	la $t5,lista	# lista iniciada
for3:
	bgt $t5,$t6,endfor3	#	p < pultimo
	
	lw $t2,0($t5)		# carregar o elemento atual
	li $v0,print_int10
	move $a0,$t2
	syscall
	li $v0,print_string
	la $a0,str2
	syscall
	addi $t5,$t5,4		# p++
	j	for3
endfor3:
	jr	$ra

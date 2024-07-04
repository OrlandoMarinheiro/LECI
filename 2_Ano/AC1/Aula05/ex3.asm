	.data
lista:  .space 40
        .align 2
str1:   .asciiz "\nIntroduza um numero: "
str2:   .asciiz "\nConteudo do array:\n"
str3:   .asciiz "; "
	.eqv SIZE,10
	.eqv TRUE,1
	.eqv FALSE,0
	.eqv print_string,4
	.eqv read_int,5
	.eqv print_int10,1
	.text
	.globl main
# $t4 -> houve troca; $t5 -> i;  #$t7 -> lista + i; $t6 -> lista 

main:	
	la $t6,lista	# inicalizar a lista
	li $t5,0	# i = 0
for1:
	bge $t5,SIZE,endfor1
	mul $t7,$t5,4	#	 tornar o i multiplo de 4
	addu $t7,$t7,$t6	# lista + i endereço de cada elemento da lista
	li $v0,print_string
	la $a0,str1
	syscall
	li $v0,read_int	#	read_int
	syscall
	sw $v0,0($t7)	#	lista[i] = read_int
	addi $t5,$t5,1	#	i++
	j	for1
endfor1:

do:
	li $t4,FALSE	#	houve troca = False
	li $t5,0	#	i = 0
	li $t3,SIZE	#	size inicializada em $t3
	subu $t3,$t3,$1	#	SIZE - 1
for2:
	bge $t5,$t3,endfor2	#	if (i < SIZE - 1);
if1:	
	mul $t7,$t5,4		#	i*4
	addu $t7,$t7,$t6	#	&lista[i] = lista + 1  endereço da memoria
	lw $t8,0($t7)		#	lista[i] = lista[i]
	lw $t9,4($t7)		# 	lista[i] = lista[i + 1]
	ble $t8,$t9,endif1
	sw $t8,4($t7)		#	lista[i] = lista[i + 1]
	sw $t9,0($t7)
	li $t4,TRUE
endif1:
	addi $t5,$t5,1		# i++ 
	j	for2
endfor2:
while:
	beq $t4,TRUE,do		#	houvetroca == True
	li $t5,0		# i= 0

for3:
	bge $t5,SIZE,endfor3	# 	i<size
	mul $t1,$t5,4		# i*4
	addu $t7,$t1,$t6	# lista[i] endereço de cada elemento
	lw $t2,0($t7)		#p = lista[i]
	li $v0,print_int10
	move $a0,$t2
	syscall
	li $v0,print_string
	la $a0,str3
	syscall
	addi $t5,$t5,1		#i++
	j	for3
endfor3:
	jr	$ra
	
	

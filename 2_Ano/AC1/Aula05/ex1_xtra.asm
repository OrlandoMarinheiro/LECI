	.data
lista:	.space 40
	.align 2
str1: 	.asciiz "; "
	.eqv SIZE,10
	.eqv read_int,5
	.eqv print_int10,1
	.eqv print_string,4
	.text
	.globl main
#$t0 -> i; $t1 -> j; $t2 -> aux; $t3 -> lista; lista + i -> $t4; lista + j -> $t5; 
# SIZE -1 -> $t6; $t7 , $t8, $t9 -> temp
main:	
	li $t0,0	#	i = 0

	li $t6,SIZE
	la $t3,lista	# endereço do primeiro elemento da lista
	addi $t6,$t6,-1		#	SIZE - 1
for:
	bge $t0,SIZE,endfor	#	i < SIZE
	mul $t7,$t0,4		#	i * 4
	addu $t7,$t3,$t7	# endereço lista + i
	li $v0,read_int		
	syscall
	
	sw $v0,0($t7) 		# lista[i] = value
	addi $t0,$t0,1		# i++
	j	for 
endfor:
	li $t0,0		# i = 0
	addiu $t1,$t0,1		# j = i + 1
for1:	
	bge $t0,$t6,endfor1	#	i < SIZE - 1
	
	addiu $t1,$t0,1		# j = i + 1
	mul $t7,$t0,4		# i * 4
	addu $t7,$t3,$t7 	# lista + i * 4 proximo endereço da lista com indice i
	lw $t4,0($t7)		# lista[i]
for2:
	bge $t1,SIZE,endfor2	#	j < SIZE
	mul $t8,$t1,4		# j * 4
	addu $t8,$t3,$t8	# lista + j * 4 proximo endereço da lista com indice j
	lw $t5,0($t8)		# lista[j]
if:	
	ble $t4,$t5,endif	# lista[i] > lista[j]
	
	lw $t4,0($t7)
	sw $t5,0($t7)
	lw $t5,0($t8)
	sw $t4,0($t8)
	
endif:
	addiu $t1,$t1,1		# j++
	j	for2
endfor2:
	addiu $t0,$t0,1		# i++	
	j	for1
endfor1:
	li $t0,0	# i = 0
for3:
	bge $t0,SIZE,endfor3	# i < SIZE
	mul $t7,$t0,4		#	i * 4
	addu $t4,$t3,$t7	# endereço lista + i
	lw $a0,0($t4)		# lista[i]
	li $v0,print_int10
	syscall
	li $v0,print_string
	la $a0,str1
	syscall
	addi $t0,$t0,1	#	i++
	j	for3
endfor3:
	jr	$ra

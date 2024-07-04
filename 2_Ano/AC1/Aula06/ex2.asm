#mapa de registos
# $t0 -> p
# $t1 -> i
# $t2 -> pultimo
	.data
	.eqv SIZE,3
	.eqv print_string, 4
  	.eqv print_char, 11  
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:   .asciiz "ponteiros"
array: 	.word str1, str2, str3
	.text
	.globl main
main:
	la $t0, array		# 	p = array
	li $t3, SIZE		
	mul $t3,$t3,4		# 	Size * 4
	addu $t2,$t0,$t3	# 	pultimo = array + SIZE

for:
	bge $t0,$t2,endfor	# 	p < pultimo
	
	lw $a0, 0($t0)		# determinar o valor na posição atual do array
	li $v0, print_string
	syscall
	
	li $v0, print_char
	li $a0, '\n'
	syscall
	
	addiu $t0,$t0,4
	j	for
endfor:
	jr	$ra
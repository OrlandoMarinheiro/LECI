#mapa de registos
# $t0 -> i
# $t1 -> j	
# $t2 -> array
# $t3 -> array + i + j
	.data
	.eqv SIZE,3
	.eqv print_string, 4
  	.eqv print_int10, 1
  	.eqv print_char, 11
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:   .asciiz "ponteiros"
str4: 	.asciiz "\nString#"
str5:	.asciiz ": "
array: 	.word str1, str2, str3
	.text
	.globl main
main:
	li $t0, 0		#	i = 0
	la $t2, array		# 	inicializar o array
for:
	bge $t0,SIZE, endfor	# 	i < SIZE
	
	li $v0,print_string
	la $a0,str4
	syscall
	
	li $v0,print_int10
	move $a0,$t0
	syscall
	
	li $v0,print_string
	la $a0,str5
	syscall
	
	li $t1, 0		# 	j = 0
while:
	mul $t3,$t0,4		# 	i * 4
	addu $t3,$t3,$t2	# 	array + i
	lw $t3,0($t3)		# 	*array[i]
	addu $t3,$t3,$t1	# 	*array[i] = &array[i][j]
	lb $t4,0($t3)		# 	*array[i][j]
	
	beq $t4,'\0',endw	# (array[i][j] != '\0'
	
	li $v0, print_char
	move $a0, $t4
	syscall
	
	li $v0,print_char
	li $a0, '-'
	syscall
	
	addiu $t1,$t1,1		#	j++
	
	j	while
endw:
	addiu $t0,$t0,1		#	i++
	j	for
endfor:
	jr	$ra
	

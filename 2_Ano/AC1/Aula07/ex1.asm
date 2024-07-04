	.data
str:	.asciiz "Arquitetura de Computadores I"
	.eqv print_int10,1
	.text
	.globl main
main:
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	la 	$a0,str
	jal 	strlen		# strlen(str)
	move 	$a0,$v0		
	
	li 	$v0, print_int10
	syscall
	
	li 	$v0, 0
	
	lw 	$ra,0($sp)		# repoe o valor de $ra
	addiu 	$sp,$sp,4		# liberta espaço na stack
	jr	$ra

###########################################################
#mapa de registos
# $t0 -> len
# $t1 -> s	
	.data
	.text
strlen:
	li $t0,0	# int len = 0
while:
	lb $t1,0($a0)		# *s
	addiu $a0,$a0,1		# *s++
	beq $t1,'\0',endw	# *s++ != '\0'
	addiu $t0,$t0,1		# len++
	j	while
endw:
	move $v0,$t0		# return len
	jr	$ra

	
	
	

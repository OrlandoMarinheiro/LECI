# mapa de registos
# $t0 -> i

	.data
	.eqv SIZE,3
	.eqv print_string, 4
  	.eqv print_int10, 1
str1:	.asciiz "Nr. de parametros: "
str2:	.asciiz "\nP"
str3:	.asciiz ": "
	.text
	.globl main
main:
	li $t2,0		# i = 0
	move $t1,$a1		# argv
	move $t0,$a0		# argc
	
	li $v0,print_string
	la $a0,str1
	syscall
	
	li $v0,print_int10
	move $a0,$t0
	syscall
for:
	bge $t2,$t0,endfor		# i < argc
	mul $t3,$t2,4			# i*4
	addu $t3,$t3,$t1		# endereço argv[i]
	lw $t4, 0($t3)
	
	li $v0,print_string	
	la $a0,str2
	syscall
	
	li $v0,print_int10
	move $a0,$t2
	syscall
	
	li $v0,print_string
	la $a0,str3
	syscall
	
	li $v0,print_string
	move $a0,$t4
	syscall
	
	addiu $t2,$t2,1		# i++
	j	for
endfor:
	jr	$ra
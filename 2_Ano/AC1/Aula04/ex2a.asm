	.data
str:	.space 21
	.eqv read_string, 8
	.eqv print_int10, 1
	.text
	.globl main
#num -> $t0
#p -> $t1
#*p -> $t2

main:	
	li $v0, 8
	la $a0, str
	li $a1, 20
	syscall		#	read_string(str, SIZE)
	
	li $t0, 0	#	num = 0;
	la $t1, str	#	p = str;
while: 

	lb $t2, 0($t1)		#dar load ao caracter atual, offset = 0
	beq $t2, $0, endw
if:
	blt $t2, '0', endif
	bgt $t2, '9', endif
	addi $t0, $t0, 1
endif:
	addi $t1, $t1, 1
	j	while
endw:
	li $v0, 1
	move $a0, $t0
	syscall
	
	jr	$ra
	
	
	
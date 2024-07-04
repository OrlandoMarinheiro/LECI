	.data
str:	.space 21
	.eqv read_string, 8
	.eqv print_int10, 1
	.text
	.globl main
#num -> $t0
#i -> $t1
#str -> $t2
#str + i -> $t3
#str[i] -> $t4
main:	
	li $v0, 8
	la $a0, str
	li $a1, 20
	syscall		#	read_string(str, SIZE)
	
	li $t0, 0
	li $t1, 0
while: 
	la $t2, str
	addu $t3, $t2, $t1	#endereço da proxima posição que será acessada na memoria
	lb $t4, 0($t3)		#dar load ao caracter atual, offset = 0
	beq $t4, $0, endw
if:
	blt $t4, '0', endif
	bgt $t4, '9', endif
	addi $t0, $t0, 1
endif:
	addi $t1, $t1, 1
	j	while
endw:
	li $v0, 1
	move $a0, $t0
	syscall
	
	jr	$ra
	
	
	
#$t0 -> gray, $t1 -> bin, $t2 -> mask	
	.data
str1: 	.asciiz "Introduza um numero: "
str2:	.asciiz "Valor em codigo Gray: "
str3: 	.asciiz "\nValor em binario: "
	.eqv print_string, 4
	.eqv read_int, 5
	.eqv print_int16, 34
	.text
 	.globl main
main:
	li $v0,4
	la $a0,str1
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	srl $t2,$t0,1
	move $t1,$t0
while:		
	beq $t2,0,endw	#	while(mask != 0) 
	xor $t1,$t1,$t2
	srl $t2,$t2,1
	j	while
endw:
	li $v0,4
	la $a0,str2
	syscall
	li $v0,34
	move $a0,$t0
	syscall
	
	li $v0,4
	la $a0,str3
	syscall
	li $v0,34
	move $a0,$t1
	syscall
	jr	$ra
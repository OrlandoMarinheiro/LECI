	.data
str: 	.asciiz "\nIntroduza um numero: "
	.align 2
lista:	.space 20
	.eqv SIZE, 5
	.eqv print_str,4
	.eqv read_int,5
# i -> $t0; lista -> $t1; lista + i (endereço da lista de i) -> $t2;
	.text
	.globl main
main:	
	li	$t0,0	# i = 0,
while:
	bge $t0,SIZE,endw
	la $a0,str
	li $v0, 4
	syscall
	
	li $v0,5
	syscall
	
	la $t1, lista
	sll $t2,$t0,2
	addu $t2,$t1,$t2
	sw $v0,0($t2)
	addi $t0,$t0,1	# i++	se for em ponteiro, teria que ser 4 em vez de 1 e addi -> addiu
	j	while
	
endw:
	
	

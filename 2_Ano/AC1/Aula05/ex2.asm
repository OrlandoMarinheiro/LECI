	.data
lista:	.word 8,-4,3,5,124,-15,87,9,27,15
str:	.asciiz "\nConteudo do array:\n"
str1:	.asciiz "; "
	.eqv print_string,4
	.eqv print_int10,1
	.eqv SIZE,10
	.text
	.globl main
#$t0 -> p; 	$t1 -> *p; 	$t2 -> SIZE	
main:
	
	la $a0,str
	li $v0,4
	syscall
	
	la $t0,lista	#	p = lista
	li $t2,SIZE	#	inicializar SIZE
	mul $t2,$t2,4	#	multiplicar por 4, para alocar a memoria necessário para o array completo -> tamamnho multiplo de 4
	addu $t2,$t2,$t0
while:
	bgeu $t0,$t2,endw
	lw $t1,0($t0)
	
	move $a0,$t1
	li $v0,print_int10
	syscall
		
	la $a0,str1
	li $v0,print_string
	syscall
	addiu $t0,$t0,4
	j	while
endw:
	jr	$ra
	

	.data
array:	.word 769,23,5,234
	.eqv print_int10, 1
	.eqv SIZE, 4	# numero de elementos do array cada um com 4 bytes
	.text
	.globl main
# $t0 -> p; $t1 -> pultimo; $t2 -> *p; $t3 -> soma;
main:	
	li $t3,0 		#	soma = 0;	
	li $t4,SIZE		# 	SIZE => $t4
	sub $t4,$t4,$1		#	SIZE-1 -> 3 bytes -> elemento anterior
	mul $t4,$t4,4		#	4 x (SIZE - 1) -> numero de bytes totais necessários que devme de ser alocados até ao penultimo elemento
	la $t0,array		#	p = array;
	addu $t1,$t0,$t4	#	pultimo=array+SIZE-1;
while:
	bgt $t0,$t1,endw	#	while( p <= pultimo )
	lw $t2,0($t0)		#	*p = array
	add $t3,$t3,$t2		
	addi $t0,$t0,4
	j	while
endw:
	li $v0,1
	move $a0,$t3
	syscall
	
	jr	$ra
	
	 

	
	
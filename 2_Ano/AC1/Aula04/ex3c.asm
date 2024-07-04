	.data
array:	.word 7692,23,5,234
	.eqv print_int10, 1
	.eqv SIZE, 4	# numero de elementos do array cada um com 4 bytes
	.text
	.globl main
# $t0 -> array; $t1 -> pultimo; $t2 -> i; $t3 -> soma; $t4 -> array[i]; $t5 -> array + i
main:	
	li $t2,0		#	i = 0;
	li $t3,0 		#	soma = 0;	
	li $t1,SIZE		# 	SIZE => $t4
	sub $t1,$t1,$1		#	SIZE-1 -> 3 bytes -> elemento anterior
	mul $t1,$t1,4		#	4 x (SIZE - 1) -> numero de bytes totais necessários que devme de ser alocados até ao penultimo elemento
	la $t0,array		#	$t0 = array;	
while:	
	add $t5,$t0,$t2	#	array + i endereço da memoria do proximo elemento
	lw $t4,0($t5)		#	dar load ao elemento atual do array -> array[i]
	
	bgt $t2,$t1,endw	#	while( i <= pultimo )

	add $t3,$t3,$t4		#	soma = soma + array[i];
	addi $t2,$t2,4		#	i++;
	j	while
endw:
	li $v0,1
	move $a0,$t3
	syscall
	
	jr	$ra
	
	 

	
	
	
	.data
str: 	.asciiz "ITED - orievA ed edadisrevinU"
	.eqv print_string,4
	.text
	.globl main
main:
	
	addiu 	$sp,$sp,-4		# alocar o espaço para a função strrev
	sw	$ra,0($sp)		
	
	la 	$a0,str			# carregar o endereço da string para $a0
	jal 	strrev
	
	move 	$a0,$v0			# copiar o valor retornado pela strrev 
	li	$v0,print_string
	syscall
	
	lw	$ra,0($sp)
	addiu 	$sp,$sp,4		# libertar o espaço para a função strrev
	jr	$ra

#################################################

	.data
	.text
# $s1 -> p1
# $s2 -> p2
# $s0 -> str -> $a0
strrev:
	addiu 	$sp,$sp,-16		# alocar espaço para a função
	sw	$ra,0($sp)		# alocar espaço para o valor returnado
	sw 	$s0,4($sp)		# guarda valor para o registo $s0
	sw	$s1,8($sp)		# guarda valor para o registo $s1
	sw	$s2,12($sp)		# guarda valor para o registo $s2
	
	move 	$s0,$a0 		# registo "callee-saved"
 	move 	$s1,$a0 		# p1 = str
 	move 	$s2,$a0 		# p2 = str 
	
while:
	lb	$t0,0($s2)		# *p2
	beq	$t0,'\0',endw		# *p2 != '\0'
	addiu	$s2,$s2,1		# p2++
	j	while
endw:
	addiu	$s2,$s2,-1		# p2--
while2:
	bge	$s1,$s2,endw1		# p1 < p2
	move 	$a1,$s1
	move	$a2,$s2
	jal	exchange
	addiu	$s1,$s1,1		# p1++
	addiu	$s2,$s2,-1		# p2--
	j	while2
endw1:
	move $v0,$s0			# return str
	
	lw	$ra,0($sp)		
	lw 	$s0,4($sp)		
	lw	$s1,8($sp)		
	lw	$s2,12($sp)		
	addiu	$sp,$sp,16		# libertar a memoria
	jr	$ra

###########################################################

	.data
	.text
exchange:
	
	lb	$t1,0($a1)
	lb	$t2,0($a2)
	sb	$t1,0($a2)
	sb	$t2,0($a1)
	jr	$ra
	

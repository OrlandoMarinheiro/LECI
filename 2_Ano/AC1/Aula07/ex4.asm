	
	.data
	.eqv	print_string,4
str1:	.asciiz "Arquitetura de "
str2:	.space 50
str3:	.asciiz "Computadores I"
str4:	.asciiz "\n"
	.text
	.globl main
main:	
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	la 	$a0,str2
	la	$a1,str1
	jal 	strcpy
	
	la	$a0,str2
	li 	$v0,print_string
	syscall
	
	la	$a0,str4
	li	$v0,print_string
	syscall
	
	la	$a0,str2
	la	$a1,str3
	jal	strcat
	move	$a0,$v0
	li	$v0,print_string
	syscall
	
	li	$v0,0
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	jr	$ra
	
##############################################
#mapa de registos
# $t0 -> $a0 -> dst
# $t1 -> $a1 -> src
	.data
	.text
strcat:
	addiu	$sp,$sp,-8
	sw	$ra,0($sp)
	sw 	$s0,4($sp)
	
	move	$s0,$a0			# guardar o valor de dst
while:
	lb 	$t2,0($a0)		# p = dst
	beq	$t2,'\0',endw		# p != '\0'
	addiu	$a0,$a0,1		# p++
	j	while		
endw:		
	jal 	strcpy
	move	$v0,$s0			# return dst
	
	lw 	$s0,4($sp)
	lw 	$ra,0($sp)
	addiu	$sp,$sp,8
	jr	$ra
########################################################
# $t0 -> &dst -> $a0
# $t1 -> &src -> $a1
	.data
	.text
strcpy:	
	li 	$t2,0		# i = 0
do:	
	addu	$t0,$t2,$a0	# &dst[i]
	addu	$t1,$t2,$a1	# &src[i]
	lb	$t4,0($t1)	# src[i]
	sb	$t4,0($t0)	# dst[i] = src[i]	
	
	addiu	$t2,$t2,1	# i++
	bne	$t4,'\0',do	# src[i++] != '\0'
while1:
	move	$v0,$a0		# return dst
	jr	$ra
	 
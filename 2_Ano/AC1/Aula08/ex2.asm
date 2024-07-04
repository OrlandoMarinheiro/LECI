# mapa de registos
# $t0 -> val

	.data
str:	.space 33
str2:	.asciiz	"\n"
	.eqv	print_string,4
	.eqv	read_int,5
	.text
	.globl main
main:
	addiu	$sp,$sp,-12
	sw	$ra,0($sp)
	sw	$s0,4($sp)	#	val
	sw	$s1,8($sp)	#	str
	
	la	$s1,str
do_main:
	li	$v0,read_int
	syscall
	move	$s0,$v0
	
	move	$a0,$s0
	li	$a1,2
	move	$a2,$s1
	jal	itoa
	
	move	$a0,$v0
	li	$v0,print_string
	syscall
	
	la	$a0,str2
	li	$v0,print_string
	syscall
	
	move	$a0,$s0
	li	$a1,8
	move	$a2,$s1
	jal	itoa
	
	move	$a0,$v0
	li	$v0,print_string
	syscall
	
	la	$a0,str2
	li	$v0,print_string
	syscall
	
	move	$a0,$s0
	li	$a1,16
	move	$a2,$s1
	jal	itoa
	
	move	$a0,$v0
	li	$v0,print_string
	syscall
	
	la	$a0,str2
	li	$v0,print_string
	syscall
	
while_main:
	bne	$s0,0,do_main
endw_main:
	li	$v0,0
	
	lw	$s1,8($sp)
	lw	$s0,4($sp)
	lw	$ra,0($sp)
	addiu	$sp,$sp,12
	jr	$ra
##################################################################

#mapa de registos
# $t0 -> digit
# $s0 -> n 
# $s1 -> b 
# $s2 -> s
# $s3 -> p
	.data
	.text
itoa:	
	addiu	$sp,$sp,-20
	sw	$ra,0($sp)	
	sw 	$s0,4($sp)	#	n
	sw	$s1,8($sp)	#	b
	sw	$s2,12($sp)	#	s
	sw	$s3,16($sp)	#	p
	
	move	$s0,$a0
	move	$s1,$a1
	move	$s2,$a2
	move	$s3,$s2
	
do_itoa:
	rem	$t0,$s0,$s1	#	digit = n % b
	div	$s0,$s0,$s1	#	n = n / b
	move	$a0,$t0		
	jal	toascii
	sb	$v0,0($s3)	# 	*p = toascii(digit)
	addiu	$s3,$s3,1	# 	*p++
while_itoa:
	bgt	$s0,0,do_itoa	
endw_itoa:
	li	$t1,'\0'
	sb	$t1,0($s3)
	move	$a0,$s2
	jal	strrev
	move	$v0,$s2
	
	lw	$s3,16($sp)
	lw	$s2,12($sp)
	lw	$s1,8($sp)
	lw 	$s0,4($sp)
	lw	$ra,0($sp)
	addiu	$sp,$sp,20
	jr	$ra
###################################################################
	
	.data
	.text
toascii:
	addi	$a0,$a0,'0'
if_toascii:
	ble	$a0,'9',endif_toascii	
	addi	$a0,$a0,7		#	v += 7
endif_toascii:
	move	$v0,$a0
	jr	$ra

###################################################################
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
	move 	$a0,$s1
	move	$a1,$s2
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
	
############################################################
	.data
	.text
exchange:
	lb	$t0,0($a0)
	lb	$t1,0($a1)
	sb	$t1,0($a0)
	sb	$t0,0($a1)
	jr	$ra
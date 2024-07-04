# mapa de registos
# $t0 -> exit_value
# $t1 -> strlen(str1)
	.data
	.eqv	STR_MAX_SIZE, 30
	.eqv	print_string,4
	.eqv	print_int10,1
str1:	.asciiz	"I serodatupmoC ed arutetiuqrA"
str2: 	.space	31
str3:	.asciiz "String too long: "
str4:	.asciiz "\n"
	.text
	.globl main
main:	
	addiu	$sp,$sp,-4
	sw 	$ra,0($sp)
	#sw	$s0,4($sp)
	
	la	$a0,str1
	jal	strlen
	move 	$t1,$v0		# strlen(str1)
if:
	bgt	$v0,STR_MAX_SIZE,else
	la	$a0,str2
	la	$a1,str1
	jal	strcpy
	
	la	$a0,str2
	li	$v0,print_string
	syscall
	
	li	$v0,print_string
	la	$a0,str4
	syscall
	
	la	$a0,str2
	jal	strrev
	
	la	$a0,str2
	li	$v0,print_string
	syscall
	
	li	$t0,0		# exit_value = 0
	j	endif
else:
	li 	$v0,print_string
	la	$a0,str3
	syscall

	li 	$v0,print_int10
	move	$a0,$t1
	syscall
	
	li	$t0,-1
endif:
	move 	$v0,$t0		# return exit_value
	#lw	$s0,4($sp)
	lw 	$ra,0($sp)
	addiu	$sp,$sp,4
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
	lb	$t3,0($t0)	# dst[i]
	addu	$t1,$t2,$a1	# &src[i]
	lb	$t4,0($t1)	# src[i]
	sb	$t4,0($t0)		# dst[i] = src[i]	
	
	addiu	$t2,$t2,1	# i++
	bne	$t4,'\0',do	# src[i++] != '\0'
while:
	move	$v0,$a0		# return dst
	jr	$ra

###########################################################

#mapa de registos
# $t0 -> len
# $t1 -> s	
	.data
	.text
strlen:
	li 	$t0,0			# int len = 0
while1:
	lb 	$t1,0($a0)		# *s
	addiu 	$a0,$a0,1		# *s++
	beq 	$t1,'\0',endw1		# *s++ != '\0'
	addiu 	$t0,$t0,1		# len++
	j	while1
endw1:
	move 	$v0,$t0		# return len
	jr	$ra
	
#######################################################

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
	
while2:
	lb	$t0,0($s2)		# *p2
	beq	$t0,'\0',endw2		# *p2 != '\0'
	addiu	$s2,$s2,1		# p2++
	j	while2
endw2:
	addiu	$s2,$s2,-1		# p2--
while3:
	bge	$s1,$s2,endw3		# p1 < p2
	move 	$a1,$s1
	move	$a2,$s2
	jal	exchange
	addiu	$s1,$s1,1		# p1++
	addiu	$s2,$s2,-1		# p2--
	j	while3
endw3:
	move 	$v0,$s0			# return str
	
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
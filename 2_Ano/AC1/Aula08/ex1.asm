	
	.data
str:	.asciiz "2020 e 2024 sao anos bissextos"
	.eqv	print_int10,1	
	.text
	.globl main
main:
	
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	la	$a0,str
	jal	atoi
	move	$a0,$v0
	li	$v0,print_int10
	syscall
	
	li	$v0,0
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	jr	$ra
	
#################################################

# mapa de registos
# $t0 -> res
# $t1 -> *s
# $t2 -> digit
	.data
	.text
atoi:
	li	$t0,0			#	res = 0
	li	$t3,'0'
while:
	lb	$t1,0($a0)		#	*s
	blt	$t1,'0',endw		#	*s >= '0'
	bgt	$t1,'9',endw		#	*s <= '9'

	sub	$t2,$t1,$t3
	addiu	$a0,$a0,1		#	s*++
	mul	$t0,$t0,10
	addu	$t0,$t0,$t2
	
	j	while
endw:	
	move	$v0,$t0
	jr	$ra
	

# mapa de registos
# $t0 -> dividendo
# $t1 -> divisor
	
	.data
str:	.asciiz "Dividendo: "
str1:	.asciiz "\nDivisor: "
	.eqv	print_string,4
	.eqv	read_int,5
	.eqv	print_int10,1
	.text
	.globl main
main:
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	la	$a0,str
	li	$v0,print_string
	syscall
	
	li	$v0,read_int
	syscall
	move	$t0,$v0
	
	la	$a0,str1
	li	$v0,print_string
	syscall
	
	li	$v0,read_int
	syscall
	move	$t1,$v0
	
	move	$a0,$t0
	move	$a1,$t1
	jal	div1
	
	move	$a0,$v0
	li	$v0,print_int10
	syscall
	
	li	$v0,0
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	jr	$ra
###################################################################

# mapa de registos
# $a0 -> dividendo
# $a1 -> divisor
# $t0 -> i
# $t1 -> bit
# $t2 -> quociente
# $t3 -> resto
	.data
	.text
div1:	
	li	$t5,0xFFFF
	li	$t6,0xFFFF0000
	
	sll	$a1,$a1,16
	and	$a0,$a0,$t5
	sll	$a0,$a0,1
	li	$t0,0			#	i = 0
for_div:
	bge	$t0,16,endfor_div
	li	$t1,0
if_div:
	blt	$a0,$a1,endif_div
	sub	$a0,$a0,$a1
	li	$t1,1
endif_div:
	sll	$a0,$a0,1
	or	$a0,$a0,$t1
	addi	$t0,$t0,1
	j	for_div
endfor_div:
	srl	$t3,$a0,1
	and	$t3,$t3,$t6
	and	$t2,$a0,$t5
	or	$v0,$t3,$t2
	jr	$ra
	

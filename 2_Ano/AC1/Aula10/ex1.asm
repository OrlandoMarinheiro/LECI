# mapa de registos
# $t0 -> i
# $f0 -> base
# $t1 -> expoente
	.data
	.eqv	read_int,5
	.eqv	print_float,2
	.eqv	read_float,6
	.eqv	print_string,4
str1:	.asciiz "Base: "
str2:	.asciiz "\nExpoente: "
str3:	.asciiz "\nResultado: "
	.text
	.globl main
main:
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	la	$a0,str1
	li	$v0,print_string
	syscall
	
	li	$v0,read_float
	syscall				#	retorna valor em $f0
	
	la	$a0,str2
	li	$v0,print_string
	syscall
	
	li	$v0,read_int
	syscall
	move	$t1,$v0			# 	expoente
	
	mov.s	$f12,$f0
	move	$a0,$t1
	jal	xtoy
	
	la	$a0,str3
	li	$v0,print_string
	syscall
	
	mov.s	$f12,$f0
	li	$v0,print_float
	syscall	
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	jr	$ra

#####################################################################################

# mapa de registos
# $f12 -> x
# $s0 -> y
# $f0 -> result
# $t0 -> i
# 
	.data
F1:	.float 1.0
	.text
xtoy:
	addiu	$sp,$sp,-8
	sw	$ra,0($sp)
	sw	$s0,4($sp)	# 	y
	
	move	$s0,$a0		#	y
	li	$t0,0		#	i = 0
	la	$t1,F1
	l.s	$f0,0($t1)	#	result = 1.0
	
	move	$a0,$s0	
	jal	abs
	move	$t2,$v0		#	abs(y)
for_xtoy:
	bge	$t0,$t2,endfor_xtoy	#	i < abs(y)
if_xtoy:
	ble	$s0,0,else_xtoy	#	y > 0
	mul.s	$f0,$f0,$f12	#	result *= x
	j	endif_xtoy
else_xtoy:
	div.s	$f0,$f0,$f12	#	result /= x
endif_xtoy:
	addi	$t0,$t0,1	#	i++
	j	for_xtoy
endfor_xtoy:
	
	lw	$s0,4($sp)
	lw	$ra,0($sp)
	addiu	$sp,$sp,8
	jr	$ra
	
#####################################################################################

# mapa de registos
# val -> $a0
	.data
	.text
abs:
if_abs:
	bge	$a0,0,endif_abs		#	val < 0
	mul	$a0,$a0,-1		#	val = -val
endif_abs:	
	move	$v0,$a0		#	return val
	jr	$ra
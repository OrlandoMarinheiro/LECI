# mapa de registos:
# $f12 -> Valor

	.data
str1:	.asciiz "Valor: "
str2:	.asciiz "\nRaiz: "
	.eqv	print_string,4
	.eqv	read_double,7
	.eqv	print_double,3
	.text
	.globl main
main:
	addiu	$sp,$sp,-8
	sw	$ra,0($sp)
	
	la	$a0,str1
	li	$v0,print_string
	syscall	
	
	li	$v0,read_double
	syscall
	mov.d	$f12,$f0
	
	la	$a0,str2
	li	$v0,print_string
	syscall	
	
	jal	sqrt
	mov.d	$f12,$f0
	li	$v0,print_double
	syscall
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,8
	jr	$ra

######################################################################################

# mapa de registos
# $t0 -> i
# $f0 -> aux
# $f2 -> xn
# $f12 -> val
	.data
D1:	.double	1.0
D2:	.double 0.5
D3:	.double 0.0
	.text
sqrt:	
	la	$t1,D1
	l.d	$f2,0($t1)	#	xn = 1.0
	li	$t0,0		#	i = 0
	la	$t1,D3
	l.d	$f4,0($t1)	#	$f4 -> 0.0
	la	$t1,D2
	l.d	$f8,0($t1)	#	$f8 -> 0.5
if:
	c.le.d	$f12,$f4	#	val > 0.0
	bc1t	else
do:
	mov.d	$f0,$f2		#	aux = xn
	
	div.d	$f6,$f12,$f2	#	val / xn
	add.d	$f6,$f2,$f6	#	xn + val / xn
	mul.d	$f2,$f6,$f8	#	xn = 0.5 * (xn + val/xn)
while_if1:
	c.eq.d	$f0,$f2		#	aux != xn
	bc1f	while_if2
	j	endif	
while_if2:
	addi	$t0,$t0,1	#	++i
	blt	$t0,25,do	#	++i < 25
	j	endif
else:
	mov.d	$f2,$f4		#	xn = 0.0
endif:
	mov.d	$f0,$f2
	jr	$ra
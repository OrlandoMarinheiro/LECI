# mapa de registos
# $f0 -> val
	.data
str:	.asciiz "Temperatura em Fahrenheit: "
str1:	.asciiz "\nTemperatura em Celsius: "
	.eqv	print_string,4
	.eqv	read_double,7
	.eqv	print_double,3
	.text
	.globl main
main:	
	addiu	$sp,$sp,-8
	sw	$ra,0($sp)
	
	la	$a0,str
	li	$v0,print_string
	syscall
	
	li	$v0,read_double
	syscall	
	mov.d	$f12,$f0
	jal	f2c
		
	la	$a0,str1
	li	$v0,print_string
	syscall
	
	mov.d 	$f12,$f0
	li	$v0,print_double
	syscall
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,8
	
# mapa de registos
# $f12 -> ft
# 

	.data
D1:	.double	5.0
D2:	.double	9.0
D3:	.double	32.0
	.text
f2c:
	la	$t0,D3
	l.d	$f0,0($t0)	#	$f0 = 32.0
	la	$t0,D2	
	l.d	$f2,0($t0)	#	$f2 = 9.0
	la	$t0,D1
	l.d	$f4,0($t0)	#	$f4 = 5.0
	
	sub.d	$f0,$f12,$f0	#	ft - 32.0	
	div.d	$f4,$f4,$f2	#	5.0 / 9.0
	mul.d	$f0,$f4,$f0	# 	5.0 / 9.0 * (ft – 32.0)
	jr	$ra
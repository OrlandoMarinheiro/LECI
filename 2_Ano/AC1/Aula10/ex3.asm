# mapa de registos:
# $t0 -> i
	.data
	.align	3
arr:	.space	24
	.eqv	SIZE,3
	.eqv	read_double,7
	.eqv	print_double,3
	.eqv	print_string,4
str1:	.asciiz "Valor: "
str2:	.asciiz	"\nMédia: "
str3:	.asciiz "\nVariância: "
str4: 	.asciiz "\nDesvio: "
	.text
	.globl main
main:
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	li	$t0,0		#	i = 0
	la	$t2,arr
for:
	bge	$t0,SIZE,endfor	#	i < SIZE
	
	la	$a0,str1
	li	$v0,print_string
	syscall
	
	li	$v0,read_double
	syscall
	mul	$t1,$t0,8	#	i * 4
	add	$t1,$t2,$t1	#	&arr[i]
	s.d	$f0,0($t1)	#	arr[i] = read_double()
	
	addi	$t0,$t0,1	#	i++
	j	for
endfor:
	la	$a0,str2
	li	$v0,print_string
	syscall
	
	la	$a0,arr
	li	$a1,SIZE
	jal	average
	
	mov.d	$f12,$f0
	li	$v0,print_double
	syscall
	
	la	$a0,str3
	li	$v0,print_string
	syscall	
	
	la	$a0,arr
	li	$a1,SIZE
	jal	var
	
	mov.d	$f12,$f0
	li	$v0,print_double
	syscall
	
	la	$a0,str4
	li	$v0,print_string
	syscall	
	
	la	$a0,arr
	li	$a1,SIZE
	jal	stdev
	
	mov.d	$f12,$f0
	li	$v0,print_double
	syscall
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	jr	$ra
####################################################################################
# mapa de registos:
# 
	.data
	.text
stdev:
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)

	jal	var
	mov.d	$f12,$f0
	jal	sqrt
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	jr	$ra
#####################################################################################

#mapa de registos
# $t0 -> i
# $f2 -> array[i]
	.data
ZERO:	.float 0.0
	.text
var:	
	addiu	$sp,$sp,-24
	sw	$ra,0($sp)
	sw	$s0,4($sp)	#	array
	sw	$s1,8($sp)	#	nval
	sw	$s2,12($sp)	#	i
	s.s	$f20,16($sp)	#	media
	s.s	$f22,20($sp)	#	soma
	
	move	$s0,$a0		#	salvaguardar array
	move	$s1,$a1		#	salvaguardar nval
	jal	average		# 	average -> return double
	cvt.s.d	$f0,$f0		#	media = (float)average(array, nval)
	mov.s	$f20,$f0
	
	li	$s2,0		#	i = 0
	
	la	$t1,ZERO	
	l.s	$f22,0($t1)	#	soma = 0.0
for_var:
	bge	$s2,$s1,endfor_var	#	i < nval
	mul	$t2,$s2,8	#	i * 8	
	add	$t2,$s0,$t2	#	&array[i]
	l.d	$f2,0($t2)	#	(double)array[i]
	cvt.s.d	$f2,$f2		#	(float)array[i]
	
	sub.s	$f2,$f2,$f20	#	((float)array[i] - media
	mov.s	$f12,$f2	
	li	$a0,2
	jal	xtoy
	add.s	$f22,$f22,$f0	#	soma += xtoy((float)array[i] - media, 2)
	
	addi	$s2,$s2,1	#	i++
	j	for_var
endfor_var:
	mtc1	$s1,$f4
	cvt.s.w	$f4,$f4		#	(double)nval
	div.s	$f0,$f22,$f4	#	return (double)soma / (double)nval
	cvt.d.s	$f0,$f0	#	(double) soma

	
	lw	$ra,0($sp)
	lw	$s0,4($sp)	#	array
	lw	$s1,8($sp)	#	nval
	lw	$s2,12($sp)	#	i
	l.s	$f20,16($sp)	#	media
	l.s	$f22,20($sp)	#	soma
	addiu	$sp,$sp,24
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
	
######################################################################################

# mapa de registos
# $t0 -> i
# $f0 -> sum
# $a1 -> n
# $a0 -> array
	.data
sum:	.double	0.0
	.text
average:
	addi	$t0,$a1,-1	#	i = n - 1
	la	$t1,sum
	l.d	$f0,0($t1)	#	sum = 0.0
for_average:
	blt	$t0,0,endfor_average	# 	i >= 0
	
	mul	$t3,$t0,8	#	i * 8
	add	$t3,$a0,$t3	#	&array[i]
	l.d	$f2,0($t3)	#	array[i]
	
	add.d	$f0,$f0,$f2	#	sum += array[i]	
	addi	$t0,$t0,-1	#	i--
	j	for_average
endfor_average:
	mtc1	$a1,$f4
	cvt.d.w	$f4,$f4		# 	converter n em double
	div.d	$f0,$f0,$f4	#	return sum / (double)n
	jr	$ra

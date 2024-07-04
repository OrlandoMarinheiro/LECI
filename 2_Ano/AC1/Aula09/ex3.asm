# mapa de registos
# $t0 -> i
	.data
	.eqv	SIZE,10
	.eqv	print_double,3
	.eqv	read_double,7
	.align	3
a:	.space	80
	.text
	.globl main
main:
	addiu	$sp,$sp,-8
	sw	$ra,0($sp)
	li	$t0,0		#	i = 0
	la	$t3,a		#	a
for:	
	bge	$t0,SIZE,endfor	#	i < SIZE
	
	li	$v0,read_double	
	syscall
	mul	$t1,$t0,8	#	i * 8
	addu	$t1,$t1,$t3	#	&a[i]
	s.d	$f0,0($t1)	#	a[i] = read_double
	
	addi	$t0,$t0,1	#	i++
	j	for	
endfor:
	la	$a0,a
	li	$a1,SIZE
	jal	average
	
	mov.d	$f12,$f0
	li	$v0,print_double
	syscall
	
	li	$v0,0
	lw	$ra,0($sp)
	addiu	$sp,$sp,8
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
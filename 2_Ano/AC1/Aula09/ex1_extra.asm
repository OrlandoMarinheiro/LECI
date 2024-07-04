# mapa de registos
# $t0 -> i
	.data
	.eqv	SIZE,10
	.eqv	print_double,3
	.eqv	read_double,7
	.eqv	print_string,4
str:	.asciiz "\n"
str1:	.asciiz "Valor: "
str2:	.asciiz "\nMédia: "
str3: 	.asciiz "\nMáximo: "
str4:	.asciiz "\nMediana: "
	.align	3
a:	.space	80
	.text
	.globl main
main:
	addiu	$sp,$sp,-8
	sw	$ra,0($sp)
	
	li	$t0,0		#	i = 0
	la	$s0,a		#	a
	li	$s1,SIZE
for:	
	bge	$t0,$s1,endfor	#	i < SIZE
	
	la $a0,str
	li $v0,print_string
	syscall	
	
	li	$v0,read_double	
	syscall
	mul	$t1,$t0,8	#	i * 8
	addu	$t1,$t1,$s0	#	&a[i]
	s.d	$f0,0($t1)	#	a[i] = read_double
	
	addi	$t0,$t0,1	#	i++
	j	for	
endfor:
	la $a0,str2
	li $v0,print_string
	syscall	
	
	la	$a0,a
	li	$a1,SIZE
	jal	average
	mov.d	$f12,$f0
	li	$v0,print_double
	syscall
	
	la $a0,str3
	li $v0,print_string
	syscall	
	
	la 	$a0,a
	li	$a1,SIZE
	jal	max
	mov.d	$f12,$f0
	li	$v0,print_double
	syscall
	
	la $a0,str4
	li $v0,print_string
	syscall	
	
	la 	$a0,a
	li	$a1,SIZE
	jal	median
	mov.d	$f12,$f0
	li	$v0,print_double
	syscall
	
	
	li	$v0,0
	lw	$ra,0($sp)
	addiu	$sp,$sp,8
	jr	$ra
	
######################################################################################

# mapa de registos
# $f0 -> max
# $t1 -> u
# $f2 -> *p

	.data
	.text
max:
	addi	$t1,$a1,-1	#	n - 1
	mul	$t1,$t1,8	#	(n - 1) * 4
	addu	$t1,$t1,$a0	#	&p+n-1	endereço do ultimo elemento do array
	
	l.d	$f0,0($a0)	#	max = *p
	addiu	$a0,$a0,8	#	*p++
for_max:
	bgt	$a0,$t1,endfor_max	#	p <= u
	l.d 	$f2,0($a0)		#	*p
if_max:	
	c.le.d	$f2,$f0
	bc1t	endif_max
	mov.d	$f0,$f2			#	max = *p
endif_max:
	addiu	$a0,$a0,8	#	p++
	j	for_max
endfor_max:
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

####################################################################################

# mapa de registos
# $t0 -> i
# $t1 -> houveTroca
	.data
	.eqv	TRUE,1
	.eqv	FALSE,0
	.text
median:
do_median:
	li	$t1,FALSE	#	houveTroca = FALSE
	li	$t0,0		#	i = 0
	addi	$t2,$a1,-1	#	$t2 = nval - 1
for_median:
	bge	$t0,$t2,endfor_median	#	i < nval - 1
	
	mul	$t3,$t0,8	#	i * 8
	addu	$t3,$t3,$a0	#	&array[i]
	l.d	$f2,0($t3)	#	array[i]
	l.d	$f4,8($t3)	#	array[i+1]
if_median:
	c.le.d	$f2,$f4		#	array[i] > array[i+1]
	bc1t	endif_median
	
	s.d	$f4,0($t3)	#	array[i] = array[i + 1]
	s.d	$f2,8($t3)	#	array[i + 1] = array[i]
	
	li	$t1,TRUE	#	houveTroca = TRUE
endif_median:
	addi	$t0,$t0,1	#	i++
	j	for_median
endfor_median:
while_median:
	beq	$t1,TRUE,do_median
endw_median:
	div	$t2,$t2,2	#	nval / 2
	mul	$t2,$t2,8	#	nval * 8
	addu	$t2,$t2,$a0	#	&array[nval/2]
	l.d	$f0,0($t2)	#	houveTroca = FALSE
	jr	$ra
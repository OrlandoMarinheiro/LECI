# mapa de registos
# $t0 -> val
# $f0 -> res
	.data
F1:	.float	2.59375
F2:	.float	0.0
	.eqv	print_float,2
	.eqv	read_int,5
	.text
	.globl main
main:

do:
	li	$v0,read_int
	syscall
	move	$t0,$v0		#	val = read_int()
	mtc1	$t0,$f0
	cvt.s.w	$f0,$f0		#	converter int val para float val
	la	$t1,F1
	l.s	$f2,0($t1)	#	2.59375
	mul.s	$f0,$f0,$f2	# 	res = (float)val * 2.59375
	mov.s	$f12,$f0
	li	$v0,print_float
	syscall
while:
	la	$t2,F2
	l.s	$f4,0($t2)	#	0.0
	c.eq.s	$f2,$f4
	bc1f	do
endw:
	li	$v0,0
	jr	$ra
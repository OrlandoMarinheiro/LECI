# typedef struct
# {
# char a1[10];
# double g;
# int a2[2];
# char v;
# float k;
# } uvw; 

# Código C	| Alinhamento | Dimensão  | Offset  
# char a1[10]	|	1     |     10    |   0  
# double g	|       8     |     8     |   10 -> 16
# int a2[2]	|       4     |     8     |   24
# char v        |       1     |     1     |   32
# float k	|	4     |     4	  |   33 -> 36
#------------------------------------------------------
# uvw  		|	8     |     40   |  ------

	.data
	.align	3
uvw:	
	.asciiz "St1"
	.space	6
	.double	3.141592653589
	.word	291,756
	.asciiz "X"
	.float	1.983
	.text
f1:
	la	$t0,uvw
	lw	$t1,28($t0)	#	a2[1]
	mtc1	$t1,$f0
	cvt.d.w	$f0,$f0		#	(double)a2[1]
	
	l.s	$f2,36($t0)	#	float k
	cvt.d.s	$f2,$f2		#	(double)k
	
	l.d	$f4,16($t0)	# 	(double)g
	
	div.d	$f8,$f0,$f2	#	(double)s1.a2[1] / (double)s1.k)
	mul.d	$f0,$f4,$f8	#	(s1.g * (double)s1.a2[1] / (double)s1.k)
	cvt.s.d	$f0,$f0		#	return (float)(s1.g * (double)s1.a2[1] / (double)s1.k);
	jr	$ra
	
######################################################################################
	.data
	.eqv	print_float,2
	.text
	.globl main
main:
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	jal	f1
	mov.s	$f12,$f0
	li	$v0,print_float
	syscall
	
	li	$v0,0
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	jr	$ra
	
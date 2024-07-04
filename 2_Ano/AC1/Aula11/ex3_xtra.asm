# typedef struct
# {
# char a1[14];
# int i;
# double g;
# char a2[17];
# } xyz; 

# Código C	| Alinhamento | Dimensão  | Offset  
# char a1[14]	|	1     |     14    |   0  
# int i		|       8     |     4     |   14 -> 16
# double g	|       8     |     8     |   20 -> 24
# char a2[17]   |       1     |     17    |   32
#------------------------------------------------------
# xyz 		|	8     |     49   |  ------
	.data
	.eqv	print_double,3
s2:
	.asciiz "Str_1"
	.space	8
	.word	2023
	.double	2.718281828459045
	.asciiz "Str_2"
	.text
	.globl main
main:
	addiu	$sp,$sp,-8
	sw	$ra,0($sp)
	
	la	$a0,s2
	jal	f2
	mov.d	$f12,$f0
	li	$v0,print_double
	syscall
	
	li	$v0,0
	lw	$ra,0($sp)
	addiu	$sp,$sp,8
	jr	$ra
#####################################################################################

	.data
D1:	.double	0.35
	.text
f2:
	l.d	$f0,24($a0)	#	$f0 -> (double)g
	
	lw	$t0,16($a0)	#	$t0 -> (int)i
	mtc1	$t0,$f2
	cvt.d.w	$f2,$f2		#	(double)i
	
	la	$t1,D1
	l.d	$f4,0($t1)	#	$f4 -> 0.35
	
	div.d	$f2,$f2,$f4	#	(double)p->i / 0.35
	mul.d	$f0,$f2,$f0	#	return p->g * (double)p->i / 0.35
	
	jr	$ra
	
	

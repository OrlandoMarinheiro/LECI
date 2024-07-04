# typedef struct ATEBÇÃO não está completamente certo
# {
# unsigned int id_number;
# char first_name[18];
# char last_name[15];
# float grade;
# } student; 

# Código C		| Alinhamento | Dimensão | Offset
# unsigned int id_number|       4     |     4    |   0
# char first_name[18]	|	1     |     18   |   4
# char last_name[15]	|       1     |     15   |   22
# float grade		|       4     |     4    |   37 -> 40
#----------------------------------------------------------
#			|	4     |     44   |  ------

		.data
str4:		.asciiz	"\nMedia: "
		.eqv	MAX_STUDENTS,4
		.eqv	print_string,4
		.eqv	print_float,2
		.align	2
st_array:	.space	176		#	4 * 44 
media:		.space	4	
		.text
		.globl main
# $t0 -> pmax
main:
		addiu	$sp,$sp,-4	# read_data
		sw	$ra,0($sp)	# read_data
		
		la	$a0,st_array
		li	$a1,MAX_STUDENTS
		jal	read_data
		
		la	$a0,st_array
		li	$a1,MAX_STUDENTS
		la	$a2,media
		jal	max
		move	$t0,$v0		# endereço onde está armazenado max
		
		la	$a0,str4
		li	$v0,print_string
		syscall
		
		la	$t1,media
		l.s	$f12,0($t1)
		li	$v0,print_float
		syscall
		
		move	$a0,$t0
		jal	print_student
		
		li	$v0,0
		
		lw	$ra,0($sp)
		addiu	$sp,$sp,4
		jr	$ra

####################################################################

	.data
	.eqv	print_string,4
	.eqv	read_int,5
	.eqv	read_float,6
	.eqv	read_string,8
str0:	.asciiz "N. Mec: "
str1:	.asciiz "Primeiro Nome: "
str2:	.asciiz "Ultimo Nome: "
str3:	.asciiz "Nota: "
	.text
read_data:
	li	$t0,0		#	i = 0	
	move	$t5,$a0
for:
	bge	$t0,$a1,endfor		#	i < ns
	mul	$t2,$t0,44	
	addu	$t2,$t2,$t5
	
	la	$a0,str0
	li	$v0,print_string	
	syscall
	
	li	$v0,read_int	
	syscall
	sw	$v0,0($t2)	
	
	la	$a0,str1
	li	$v0,print_string	
	syscall
	
	li	$v0,read_string
	addiu	$a0,$t2,4	#	endereço do first_name
	li	$a1,17
	syscall
	
	la	$a0,str2
	li	$v0,print_string
	syscall
	
	li	$v0,read_string
	addiu	$a0,$t2,22	#	endereço do last_name
	li	$a1,15
	syscall
	
	la	$a0,str3
	li	$v0,print_string
	syscall
	
	li	$v0,read_float
	syscall
	s.s	$f0,40($t2)	#	armazenar grade
	
	addi	$t0,$t0,1	#	i++
	j	for
endfor:	
	jr	$ra

###########################################################################
# mapa de registos
# $t0 -> p
# $t3 -> pmax
# $f2 -> sum
# $f4 -> max_grade
	.data
F1:	.float	-20.0
F2:	.float	0.0
	.text
max:	
	move	$t0,$a0		#	p = st
	addu	$t1,$a0,$a1	#	st + ns	
	la	$t2,F2
	l.s	$f2,0($t2)	#	sum = 0.0
	la	$t2,F1
	l.s	$f4,0($t2)	#	max_grade = -20.0
for_max:
	bge	$t0,$t1,endfor_max	#	p < (st + ns)
	l.s	$f0,40($t0)		#
	add.s	$f2,$f2,$f0		#	sum += p.grade
if_max:
	c.le.s	$f0,$f4
	bc1t	endif_max		#	if(p->grade > max_grade)
	mov.s	$f4,$f0			#	max_grade = p.grade
	move	$t3,$t0			#	pmax = p
endif_max:
	addi	$t0,$t0,4		#	p++
	j	for_max
endfor_max:
	mtc1	$a1,$f6
	cvt.s.w	$f6,$f6			# 	(float)ns
	div.s	$f12,$f2,$f6		#	sum / (float)ns
	move	$v0,$t3			# 	return pmax
	jr	$ra
###########################################################################
# mapa de registos:
#
	.data
	.eqv	print_int10,1
	.eqv	print_string,4
	.eqv	print_float,2
	.text
print_student:
	
	move	$t0,$a0
	lw	$a0,0($t0)
	li	$v0,print_string
	syscall
	
	addi	$a0,$t0,4
	li	$v0,print_string
	syscall
	
	addi	$a0,$t0,22
	li	$v0,print_string
	syscall
	
	l.s	$f12,40($t0)
	li	$v0,print_float
	syscall
	
	jr	$ra

	
		
	
		
		
						
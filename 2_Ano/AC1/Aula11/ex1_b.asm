# typedef struct
# {
# unsigned int id_number;
# char first_name[18];
# char last_name[15];
# float grade;
# } student;

# Código C	| Alinhamento | Dimensão | Offset
# int id_number	|	4     |     4    |   0
# first_name[18]|       1     |     18   |   4
# last_name[15] |       1     |     15   |   22
# float_grade   |       4     |     4    |   37 -> 40
#------------------------------------------------------
#		|	4     |     44   |  ------

	.data
	.eqv	print_string,4
	.eqv	print_intu10,36
	.eqv 	print_char,11
	.eqv	print_float,2
	.eqv	read_int,5
	.eqv	read_string,8
	.eqv	read_float,6
	.align	2
stg:
n_mec:	.space	4
f_name:	.space	18
l_name:	.space	15
grade:	.space	4

str1:	.asciiz "\nN. Mec: "
str2:	.asciiz "\nNome: "
str3:	.asciiz "\nNota: "
str4:	.asciiz "\nPrimeiro Nome: "
str5:	.asciiz "\nUltimo Nome: "
	.text
	.globl main
main:
	la	$t0,stg
	
	la	$a0,str1
	li	$v0,print_string
	syscall
	li	$v0,read_int
	syscall
	sw	$v0,0($t0)	#	armazenar o num mecanografico em stg
	
	la	$a0,str4
	li	$v0,print_string
	syscall
	li	$v0,read_string	
	addiu	$a0,$t0,4	#	armazenar o primeiro nome
	li	$a1,17
	syscall
	
	la	$a0,str5
	li	$v0,print_string
	syscall
	li	$v0,read_string	
	addiu	$a0,$t0,22	#	armazenar o ultimo nome
	li	$a1,16
	syscall
	
	la	$a0,str3
	li	$v0,print_string
	syscall
	li	$v0,read_float
	syscall
	s.s	$f0,40($t0)	#	armazenar a nota
	
	
	la	$a0,str1
	li	$v0,print_string
	syscall
	
	lw	$a0,0($t0)	
	li	$v0,print_intu10
	syscall
	
	la	$a0,str2
	li	$v0,print_string
	syscall
	
	addiu	$a0,$t0,22		#	endereço de last_name
	li	$v0,print_string
	syscall
	
	li	$a0,','
	li	$v0,print_char
	syscall
	
	addiu	$a0,$t0,4		#	endereço do first_name
	li	$v0,print_string
	syscall
	
	la	$a0,str3
	li	$v0,print_string
	syscall
	
	l.s	$f12,40($t0)
	li	$v0,print_float
	syscall
	
	li	$v0,0
	jr	$ra
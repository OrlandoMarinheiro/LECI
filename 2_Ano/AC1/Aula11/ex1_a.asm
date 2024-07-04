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
	.align	2
stg:
	.word	72343
	.asciiz "Napoleao"
	.space	9
	.asciiz "Bonaparte"
	.space	5
	.float 5.1
str1:	.asciiz "\nN. Mec: "
str2:	.asciiz "\nNome: "
str3:	.asciiz "\nNota: "
	.text
	.globl main
main:
	la	$t0,stg

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
	
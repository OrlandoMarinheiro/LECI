	.data
str:	.space 21
str1:	.asciiz "Introduza uma string: "
	.eqv print_string,4
	.eqv read_string,8
	.text
	.globl main
#$t0 -> *p; $t1 -> p; 
main:	
	li $v0,4
	la $a0,str1
	syscall
	
	li $v0,8
	la $a0,str
	li $a1,20
	syscall
	
	la $t1,str		#	p = str
while:	
	lb $t0,0($t1)		#	vai dar load ao caracter atual e copiar o seu endereço para *p => *p = str[i]
	beq $t0,0,endw		#	while (*p != '\0') 
if:	
	li $t3,0x61		#	'a'
	li $t4,0x41		#	'A'
	li $t5,0x5A		#	'Z'
	li $t6,0x7A		#	'z'
	blt $t0,$t3,endif	#	if(*p >= 'a' && *P <= 'z')
	bgt $t0,$t6,endif
	
	subu $t0,$t0,$t3	#	*p = *p – 'a' 
	addu $t0,$t0,$t4	# 	*p = *p + 'A' 
endif:	
	sb $t0,0($t1)		# vai armazenar o valor que $t0 contém na posição da memória de $t1, ou seja str[i] toma valor de *p
	addi $t1,$t1,1
	j	while
endw:
	li $v0,4
	la $a0,str
	syscall
	jr	$ra
	
	
	
	
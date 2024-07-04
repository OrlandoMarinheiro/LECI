# value -> $t0, bit -> $t1, i -> $t2, $t7 -> flag
	.data
str1:	.asciiz "Introduza um numero: "
str2: 	.asciiz	"O valor em binario e: "
	.eqv read_int, 5
	.eqv print_string, 4
	.eqv print_char, 11
	.text
 	.globl main
main:
	li $t7,0	#	flag = 0
 	li $t2,0
 	
 	li $v0, print_string
 	la $a0, str1
 	syscall
 	
 	li $v0, read_int
 	syscall
 	move $t0, $v0
 	
 	li $v0, print_string
 	la $a0, str2
 	syscall
while: 
	bge $t2, 32, endw	#	while(i < 32) {
	srl $t1,$t0,31		#	bit = value >> 31
if:	
	bne $t7,1,segunda_condicao	#	if(flag == 1)
	li $t7,1
	rem $t3,$t2,4	
	j	if1	
segunda_condicao:
	beq $t1,0,endif				#	if(bit != 0)
	li $t7,1
	rem $t3,$t2,4
if1: 	
	bne $t3,0,endif_1
	li $v0, print_char
	li $a0, ' '
	syscall
endif_1:
	li $t4,0x30		# $t4 = 0x30
	add $t5,$t4,$t1		# $t5 = 0x30 + bit
	
	li $v0,print_char
	move $a0,$t5
	syscall
endif:	
	sll $t0,$t0,1
	addi $t2, $t2, 1	
	j	while
endw:
	jr	$ra	
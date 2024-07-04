# value -> $t0, bit -> $t1, i -> $t2
	.data
str1:	.asciiz "Introduza um numero: "
str2: 	.asciiz	"O valor em binario e: "
	.eqv read_int, 5
	.eqv print_string, 4
	.eqv print_char, 11
	.text
 	.globl main
main:
 	li $t2, 0
 	
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
	li $t3, 0x80000000
	and $t1, $t0, $t3 	# bit = value & 0x80000000;
if:
	beq $t1, $0, else	#	if( bit != 0)
	li $v0, print_char
	li $a0, '1'
	syscall
	j	endif	
else:
	li $v0, print_char
	li $a0, '0'
	syscall
endif:	
	sll $t0, $t0, 1
	addi $t2, $t2, 1	
	j	while
	
endw:
	jr	$ra
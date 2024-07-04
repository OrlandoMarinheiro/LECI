#res -> $t0, i -> $t1, mdor -> $t2, mdo -> $t3
	.data
str1:	.asciiz "Introduza dois numeros: \n"
str2: 	.asciiz "Resultado: "
	.eqv print_string,4
	.eqv read_int,5
	.eqv print_int10,1
	.text
	.globl main
main:	
	li $v0,4
	la $a0,str1
	syscall
	
	li $v0,5
	syscall
	move $t2,$v0
	li $t4,0xFFFF	#$t4 = 0xFFFF
	and $t2,$t2,$t4 	#	mdor = read_int() & 0xFFFF
	
	li $v0,5
	syscall
	move $t3,$v0
	and $t3,$t3,$t4		#	mdo = read_int() & 0xFFFF
while:
	beq $t2,0,endw
	bge $t1,4,endw
	li $t5,0x00000001	#	$t5 = 0x00000001
	and $t6,$t2,$t5		#	$t6 = mdor & 0x00000001
if:
	beq $t6,0,endif
	add $t0,$t0,$t3		#	$t0 = res = res + mdo
endif:
	sll $t3,$t3,1
	srl $t2,$t2,1
	addi $t1,$t1,1
	j	while
endw:	
	li $v0,4
	la $a0,str2
	syscall
	
	li $v0,1
	move $a0,$t0
	syscall
	jr	$ra

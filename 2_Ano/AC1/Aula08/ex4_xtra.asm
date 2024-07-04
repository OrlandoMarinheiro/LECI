		.data
		.align 2
array:		.space	12
aux_array:	.space	12
		.eqv SIZE,3
		.eqv print_string,4
		.eqv print_int10,1
		.eqv read_int,5
str1:		.asciiz "array["
str2:		.asciiz "]="
str3:		.asciiz "*, "
str4:		.asciiz ", "
str5:		.asciiz "\n# repetidos: "
		.text
		.globl main
# mapa de registos
# $t0 -> i
# $t1 -> dup_counter
main:
	addiu	$sp,$sp,-20
	sw	$ra,0($sp)
	sw	$s0,4($sp)	#	array
	sw	$s1,8($sp)	# 	aux_array
	sw	$s2,12($sp)	#	SIZE
	sw	$s3,16($sp)	#	dup_counter
	
	la	$s0,array
	la	$s1,aux_array
	li	$s2,SIZE
	li	$s3,0		#	dup_counter = 0
	
	li	$t0,0		#	i = 0
for:
	bge	$t0,$s2,endfor
	
	la	$a0,str1
	li	$v0,print_string
	syscall
	
	move	$a0,$t0
	li	$v0,print_int10
	syscall
	
	la	$a0,str2
	li	$v0,print_string
	syscall
	
	li	$v0,read_int
	syscall
	mul	$t2,$t0,4	#	i * 4
	addu	$t2,$t2,$s0
	sw	$v0,0($t2)
	
	addi	$t0,$t0,1	#	i++
	j	for
endfor:
	
	move	$a0,$s0
	move	$a1,$s1
	move	$a2,$s2
	jal	find_duplicates
	
	li	$t0,0		# i = 0
for2:
	bge	$t0,$s2,endfor2
	
	mul	$t3,$t0,4	# i * 4
	addu	$t3,$s1,$t3	# &aux_array[i]
	lw	$t4,0($t3)	# aux_array[i]
if:
	blt	$t4,2,else
	
	la	$a0,str3
	li	$v0,print_string
	syscall
	
	addi	$s3,$s3,1	# dup_counter++
	j	endif
else:
	mul	$t5,$t0,4	# i * 4
	addu	$t5,$s0,$t5	# &array[i]
	lw	$t6,0($t5)	# array[i]
	
	move	$a0,$t6
	li	$v0,print_int10
	syscall
	
	la	$a0,str4
	li	$v0,print_string
	syscall
endif:	
	addi	$t0,$t0,1		# i++
	j	for2
endfor2:
	
	la	$a0,str5
	li	$v0,print_string
	syscall
	
	move	$a0,$s3
	li	$v0,print_int10
	syscall
	
	li 	$v0,0
	lw	$ra,0($sp)
	lw	$s0,4($sp)	
	lw	$s1,8($sp)	
	lw	$s2,12($sp)
	lw	$s3,16($sp)
	addiu	$sp,$sp,20
	jr	$ra
######################################################################################
# mapa de registos
# $t0 -> i
# $t1 -> j

	.data
	.text
find_duplicates:
	li	$t0,0		#	i = 0	
for1_find_duplicates:
	bge	$t0,$a2,endfor1_find_duplicates
	
	mul	$t1,$t0,4	#	i * 4
	addu	$t1,$a1,$t1	#	&dup_array[i]
	sw	$0,0($t1)	#	dup_array[i]
	
	li	$t2,0		#	j = 0
	li	$t3,1		#	token = 1
for2_find_duplicates:
	bge	$t2,$a2,endfor2_find_duplicates
	
	mul	$t4,$t2,4	#	j * 4
	addu	$t4,$a0,$t4	#	&array[j]
	lw	$t6,0($t4)	#	array[j]
	
	mul	$t5,$t0,4	#	i * 4
	addu	$t5,$a0,$t5	#	&array[i]
	lw	$t7,0($t5)	#	array[i]
if_find_duplicates:
	bne	$t7,$t6,endif_find_duplicates
	
	mul	$t8,$t2,4	#	j * 4
	addu	$t8,$a1,$t8	#	&dup_array[j]     ??????
	sw	$t3,0($t8)	#	dup_array[j] = token
	
	addi	$t3,$t3,1	#	token++
endif_find_duplicates:
	addi	$t2,$t2,1	#	j++
	j	for2_find_duplicates	
endfor2_find_duplicates:
	addi	$t0,$t0,1	#	i++
	j	for1_find_duplicates
endfor1_find_duplicates:
	jr	$ra

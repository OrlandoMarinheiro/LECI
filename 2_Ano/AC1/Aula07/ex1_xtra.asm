	.data
array:	.space 200
str:	.asciiz "Size of array : "
str1:	.asciiz "array["
str2:	.asciiz "] = "
str3:	.asciiz "Enter the value to be inserted: "
str4:	.asciiz "Enter the position: "
str5: 	.asciiz "\nOriginal array: "
str6:	.asciiz "\nModified array: "
	.eqv	print_string,4
	.eqv	print_int10,1
	.eqv	read_int,5
	.text
	.globl main
# mapa de registos:
# $t0 -> i
# $t1 -> array_size -> $s0
# $t2 -> insert_value -> $s1
# $t3 -> insert_pos -> $s2
# $t4 -> array -> $s3
# $t5 -> array[i]
main:
	addiu	$sp,$sp,-20
	sw	$ra,0($sp)
	sw	$s0,4($sp)
	sw	$s1,8($sp)
	sw	$s2,12($sp)
	sw	$s3,16($sp)
	
	la	$s3,array	#	&array
	
	la	$a0,str
	li	$v0,print_string
	syscall
	
	li	$v0,read_int
	syscall
	move	$s0,$v0		#	array_size = read_int()
	
	li	$t0,0		#	i = 0
for2:
	bge	$t0,$s0,endfor2	#	i < array_size
	
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
	mul	$t5,$t0,4	#	i * 4
	addu	$t5,$t5,$s3
	sw	$v0,0($t5)	#	array[i] = read_int
	
	addi	$t0,$t0,1
	j	for2
endfor2:

	la	$a0,str3
	li	$v0,print_string
	syscall
	
	li	$v0,read_int
	syscall
	move	$s1,$v0		#	insert_value = read_int
	
	la	$a0,str4
	li	$v0,print_string
	syscall
	
	li	$v0,read_int
	syscall
	move	$s2,$v0		#	insert_pos = read_int
	
	la	$a0,str5
	li	$v0,print_string
	syscall
	
	move	$a0,$s3
	move	$a1,$s0
	jal	print_array
	
	move	$a0,$s3
	move	$a1,$s1
	move	$a2,$s2
	move	$a3,$s0
	jal	insert
	
	la	$a0,str6
	li	$v0,print_string
	syscall
	
	move	$a0,$s3
	addi	$a1,$s0,1
	jal	print_array
	
	li	$v0,0
	
	lw	$s3,16($sp)
	lw	$s2,12($sp)
	lw	$s1,8($sp)
	lw	$s0,4($sp)
	lw	$ra,0($sp)
	addiu	$sp,$sp,20
	jr	$ra
	
################################################

# mapa de registos
# $t1 -> i
	.data
	.text
insert:
	move	$t0,$a0
if:	
	ble	$a2,$a3,else	#	pos > size
	li	$v0,1		#	return 1
	j	endif
else:
	addi	$t1,$a3,-1	#	size - 1
for:
	blt	$t1,$a2,endfor	#	i >= pos
	mul	$t2,$t1,4	# 	i * 4
	addu	$t2,$t2,$t0	#	&array[i]
	lw	$t3,0($t2)	#	array[i]
	sw	$t3,4($t2)	#	array[i+1] = array[i]
	addi	$t1,$t1,-1	#	p--
	j	for
endfor:
	mul	$t4,$a2,4	#	pos * 4
	addu	$t4,$t4,$t0	#	&array[pos]
	sw	$a1,0($t4)	#	array[pos] = value
	li	$v0,0		# 	return 0
endif:
	jr	$ra

###################################################

	.data
str7:	.asciiz ", "
	.eqv	print_string,4
	.eqv 	print_int10,1
	.text
print_array:
	move	$t0,$a0
	move	$t1,$a1
	mul	$t1,$t1,4	#	n * 4
	addu	$t2,$t1,$t0	#	p = a + n
for1:
	bge	$t0,$t2,endfor1	#	a < p
	
	lw	$a0,0($t0)	# 	*a
	li	$v0,print_int10
	syscall
	
	la	$a0,str7
	li	$v0,print_string
	syscall
	
	addi	$t0,$t0,4	#	a++
	j	for1
endfor1:
	jr	$ra

#mapa de registos
# $t0 -> insert_pos
	.data
str1:	.space	101
str2:	.space	51
str3:	.asciiz "Enter a string: "
str4:	.asciiz "Enter a string to insert: "
str5:	.asciiz	"Enter the position: "
str6:	.asciiz	"Original string: "
str7:	.asciiz	"\nModified string: "
str8:	.asciiz "\n"
	.eqv	print_string,4
	.eqv	read_string,8
	.eqv	read_int,5
	.text
	.globl main
main:
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	la	$a0,str3
	li	$v0,print_string
	syscall
	
	la	$a0,str1
	li	$a1,50
	li	$v0,read_string
	syscall
	
	la	$a0,str4
	li	$v0,print_string
	syscall
	
	la	$a0,str2
	li	$a1,50
	li	$v0,read_string
	syscall
	
	la	$a0,str5
	li	$v0,print_string
	syscall
	
	li	$v0,read_int
	syscall
	move	$t0,$v0
	
	la	$a0,str6
	li	$v0,print_string
	syscall
	
	la	$a0,str1
	li	$v0,print_string
	syscall
	
	la	$a0,str1
	la	$a1,str2
	move	$a2,$t0
	jal	insert
	
	la	$a0,str7
	li	$v0,print_string
	syscall
	
	la	$a0,str1
	li	$v0,print_string
	syscall
	
	la	$a0,str8
	li	$v0,print_string
	syscall
	
	li	$v0,0
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	jr	$ra
######################################################################################

#mapa de registos
# $s0 -> dst
# $s1 -> src
# $a2 -> pos
# $t0 -> i
# $s2 -> len_dst
# $s3 -> len_src
# $s4 -> p
	.data
	.text
insert:
	addiu	$sp,$sp,-24
	sw	$ra,0($sp)
	sw	$s0,4($sp)	#	dst
	sw	$s1,8($sp)	#	src
	sw	$s2,12($sp)	#	len_dst
	sw	$s3,16($sp)	#	len_src
	sw	$s4,20($sp)	#	p
	
	move	$s4,$a0		#	*p = dst
	move	$s0,$a0	
	jal	strlen		#	len_dst = strlen(dst)
	move	$s2,$v0
	
	move	$s1,$a1
	move	$a0,$s1
	jal	strlen		# 	len_src = strlen(src)
	move	$s3,$v0
	
if_insert:
	bgt	$a2,$s2,endif_insert
	move	$t0,$s2			#	i = len_dst
for1_insert:
	blt	$t0,$a2,endfor1_insert
	add	$t1,$t0,$s3		#  	i + len_dst
	add	$t1,$s0,$t1		#	&dst[i + len_src]
	add	$t2,$s0,$t0		#	&dst[i]
	lb	$t3,0($t2)		#	dst[i]
	sb	$t3,0($t1)		# 	dst[i + len_src] = dst[i]
	addi	$t0,$t0,-1		#	i--
	j	for1_insert
endfor1_insert:
	li	$t0,0			#	i = o
for2_insert:
	bge	$t0,$s3,endfor2_insert
	add	$t4,$t0,$a2		#	i + pos
	add	$t4,$s0,$t4		#	&dst[i + pos]
	add	$t5,$t0,$s1		#	&src[i]
	lb	$t6,0($t5)		#	src[i]
	sb	$t6,0($t4)		#	dst[i + pos] = src[i]
	addi	$t0,$t0,1		#	i++
	j	for2_insert
endfor2_insert:
endif_insert:
	move	$v0,$s4
	
	lw	$ra,0($sp)
	lw	$s0,4($sp)
	lw	$s1,8($sp)
	lw	$s2,12($sp)
	lw	$s3,16($sp)
	lw	$s4,20($sp)
	addiu	$sp,$sp,24
	jr	$ra
	
#####################################################################################
	.data
	.text
strlen:
	li $v0,0
strlen_while0:
	lb $t0,0($a0)
	addiu $a0,$a0,1
	beq $t0,'\0',strlen_endwhile0
	addi $v0,$v0,1
	j strlen_while0
strlen_endwhile0:
	jr $ra		
		
		
		
	

	
	
	
	
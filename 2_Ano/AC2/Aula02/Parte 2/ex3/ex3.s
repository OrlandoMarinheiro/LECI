# mapa de registos
# counter - $t0
# delay - $t3

    .equ 	put_char, 3
    .equ 	print_int, 6
    .equ 	reset_core_timer, 12
    .equ 	read_core_timer, 11
    .equ 	print_string, 8
    .equ	inKey,1
    .data
    .text
    .globl main
main: 
    addiu	$sp, $sp, -20
    sw		$ra, 0($sp)
    sw		$s0, 4($sp)
    sw 		$s1, 8($sp)
    sw		$s2, 12($sp)
    sw 		$s3, 16($sp)
    
    li		$s0,0			# int cnt1 = 0
    li		$s1,0			# int cnt5 = 0
    li		$s2,0			# int cnt10 = 0
    li		$s3,100
    
while:

    li		$v0,inKey
    syscall
if3:
    bne		$v0,'A',endif3		# 50% frequencia
    li		$s3,50
endif3:
if4:
    bne		$v0,'N',endif4		# 100% frequencia
    li		$s3,100
endif4:
    move	$a0,$s3
    jal		delay
    
    li		$v0,put_char
    la		$a0,'\r'
    syscall
    
    li  	$t1, 4
    sll 	$t1, $t1, 16
    li  	$t2,10
    or 		$a1, $t2, $t1
    
    li		$v0,print_int
    move 	$a0,$s0
    syscall
    
    addiu	$s0,$s0,1		# cnt10++
    
 if1:
    remu	$t4,$s0,2
    bne		$t4,0,endif1
    addiu	$s1,$s1,1
 endif1:
 
 if2:
    li		$t3,10
    remu	$t5,$s0,$t3
    bne		$t5,0,endif2
    addiu	$s2,$s2,1
 endif2:
    
    li		$v0,put_char
    la		$a0,' '
    syscall
    
    li  	$t1, 4
    sll 	$t1, $t1, 16
    li  	$t2,10
    or 		$a1, $t2, $t1
    
    li		$v0,print_int
    move 	$a0,$s1
    syscall
    
    li		$v0,put_char
    la		$a0,' '
    syscall
    
    li  	$t1, 4
    sll 	$t1, $t1, 16
    li  	$t2,10
    or 		$a1, $t2, $t1
    
    li		$v0,print_int
    move 	$a0,$s2
    syscall
     	
    j		while
    lw		$ra, 0($sp)
    lw		$s0, 4($sp)
    lw 		$s1, 8($sp)
    lw		$s2, 12($sp)
    lw		$s3, 16($sp)
    addiu	$sp, $sp, 20
    
delay:
    li 		$v0, reset_core_timer
    syscall
while2:
    li 		$v0, read_core_timer
    syscall
    mul 	$t0, $a0, 20000
    
    blt 	$v0, $t0, while2
endwhile2:
    jr 		$ra

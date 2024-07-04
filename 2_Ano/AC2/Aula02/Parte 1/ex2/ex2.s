# mapa de registos
# counter - $t0
# delay - $t3

    .equ 	put_char, 3
    .equ 	print_int, 6
    .equ 	reset_core_timer, 12
    .equ 	read_core_timer, 11
    .equ 	print_string, 8
    .equ 	read_int, 5
    .data
str:.asciiz 	"Introduza um valor:\n"
    .text
    .globl main
main:   
    addiu   	$sp, $sp, -8
    sw  	$ra, 0($sp)
    sw  	$s0, 4($sp)

    li  	$s0,0

    li  	$v0, print_string
    la  	$a0, str
    syscall
    
    li 		$v0, read_int
    syscall
    move    	$t9,$v0

while:

    li  	$a0,'\r'
    li  	$v0,put_char
    syscall

    li  	$t1, 4
    sll 	$t1, $t1, 16
    li  	$t2,10
    or 		$a1, $t2, $t1
    
    move 	$a0, $s0 
    li  	$v0, print_int
    syscall

    move    	$a0,$t9
    jal     	delay  
    addi    	$s0,$s0,1

    j   	while
    li  	$v0, 0

    lw  	$ra, 0($sp)
    lw  	$s0, 4($sp)
    addiu   	$sp, $sp, 8
    jr  	$ra


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

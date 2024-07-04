# mapa de registos
# counter - $t0
# ex1 - c) para 10Hz ajustar o tempo de espera para 2 000 000
#          para 5Hz ajustar o tempo de espera para 4 000 000
#          para 1Hz ajustar o tempo de espera para 20 000 000
# conclusão: quanto menor a frequencia, mais tempo demora o cronometro a contar, devido ao tempo de espera ser maior

    .equ 	put_char, 3
    .equ 	print_int, 6
    .equ 	reset_core_timer, 12
    .equ 	read_core_timer, 11
    .data
    .text
    .globl main
main:   
    li  	$t0,0
while:
    li  	$a0,'\r'
    li  	$v0,put_char
    syscall

    li  	$t1, 4
    sll 	$t1, $t1, 16
    li  	$t2,10
    or 		$a1, $t2, $t1

    move 	$a0, $t0 
    li  	$v0, print_int
    syscall
    
    li 		$v0, reset_core_timer
    syscall

while1:
    li  	$v0, read_core_timer
    syscall
    blt 	$v0, 20000000, while1
    addi 	$t0,$t0,1
    j 		while
endw:
    li  	$v0, 0
    jr  	$ra



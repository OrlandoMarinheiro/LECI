
    .equ READ_CORE_TIMER,11 
    .equ RESET_CORE_TIMER,12

    .equ ADDR_BASE_HI, 0xBF88
	.equ TRISE, 0x6100
	.equ PORTE, 0x6110
	.equ LATE, 0x6120

	.equ TRISB, 0x6040
	.equ PORTB, 0x6050
	.equ LATB, 0x6060
	.data
	.text
	.globl main
main:
    addiu   $sp, $sp, -12           
    sw      $ra, 0($sp)            
    sw      $s0, 4($sp)             
    sw      $s1, 8($sp)            

    li      $s1, 0

    lui     $s0, ADDR_BASE_HI
    lw      $t1, TRISE($s0)      # read the current value of TRISE
    andi    $t1, $t1, 0xFFF0       # set RE1, RE2, RE3, RE4 as output
    sw      $t1, TRISE($s0)

    lw      $t1, TRISB($s0)      # read the current value of TRISB  
    ori     $t1, $t1, 0x000E     # set RB1, RB2, RB3 as input
    sw      $t1, TRISB($s0)

loop:

    lw      $t1, LATE($s0)       # read the current value of LATE
    andi    $t1, $t1, 0xFFF0       # clear RE1, RE2, RE3, RE4
    or      $t1, $t1, $s1         # set RE1, RE2, RE3, RE4
    sw      $t1, LATE($s0)

    li      $a0, 250              # 250 ms delay 4Hz
    jal delay
    
    addi    $s1, $s1, -1           # decrement s1 
    andi    $s1, $s1, 0x000F       

    j       loop

    lw      $ra, 0($sp)            
    lw      $s0, 4($sp)            
    lw      $s1, 8($sp)            
    addiu   $sp, $sp, 12          
    jr      $ra                   

delay:
    li 		$v0, RESET_CORE_TIMER
    syscall
while2:
    li 		$v0, READ_CORE_TIMER
    syscall
    mul 	$t0, $a0, 20000
    
    blt 	$v0, $t0, while2
endwhile2:
    jr 		$ra
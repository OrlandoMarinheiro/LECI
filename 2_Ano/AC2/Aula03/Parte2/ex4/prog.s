
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

    li      $s1, 0x0001            # inicializa o valor de s1 com 1

    lui     $s0, ADDR_BASE_HI
    lw      $t1, TRISE($s0)      # read the current value of TRISE
    andi    $t1, $t1, 0xFFF0       # set RE1, RE2, RE3, RE4 as output
    sw      $t1, TRISE($s0)

    lw      $t1, TRISB($s0)      # read the current value of TRISB  
    ori     $t1, $t1, 0x0001     # set RB0 as input
    sw      $t1, TRISB($s0)

loop:

    lw      $t1, LATE($s0)       # read the current value of LATE
    andi    $t1, $t1, 0xFFF0       # clear RE1, RE2, RE3, RE4
    or      $t1, $t1, $s1         # set RE1, RE2, RE3, RE4
    sw      $t1, LATE($s0)


    li      $v0, RESET_CORE_TIMER
    syscall
 wait:
    li      $v0, READ_CORE_TIMER
    syscall
    blt     $v0, 6666667, wait      # frequencia de icremento de 3hz (6666667)


    lw      $t1,PORTB($s0)          # read the current value of LATB
    andi    $t1, $t1, 0x0001        # clear RB0

if:
    beq     $t1, $zero, else       
    andi    $t3, $s1, 0x0008        # verifica se o bit mais significativo é 1
    sll     $s1, $s1, 1             # shift right s1
    bne     $t3, 8, loop            # if s1 != 0, jump to loop
    ori     $s1, $s1, 0x0001        # caso seja 1000, definir s1 para 0001
    j       loop                    # jump to loop
else:
    andi    $t3, $s1, 0x0001        # verifica se o bit menos significativo é 1 
    srl     $s1, $s1, 1             # shift left s1
    bne     $t3, 1, loop            # if s1 != 0, jump to loop
    ori     $s1, $s1, 0x0008        # caso seja 0000, definir s1 para 1000
    j       loop                    # jump to loop

    lw      $ra, 0($sp)            
    lw      $s0, 4($sp)            
    lw      $s1, 8($sp)            
    addiu   $sp, $sp, 12          
    jr      $ra                   
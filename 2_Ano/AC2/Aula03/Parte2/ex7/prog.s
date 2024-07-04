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

    li      $s1, 0            # inicializa o valor de s1 com 1

    lui     $s0, ADDR_BASE_HI
    lw      $t1, TRISE($s0)      # read the current value of TRISE
    andi    $t1, $t1, 0xFFF0       # set RE1, RE2, RE3, RE4 as output
    sw      $t1, TRISE($s0)

    lw      $t1, TRISB($s0)      # read the current value of TRISB  
    ori     $t1, $t1, 0x000F     # set RB0 as input
    sw      $t1, TRISB($s0)

loop:

    lw      $t1, LATE($s0)       # read the current value of LATE
    andi    $t1, $t1, 0xFFF0       # limpa RE1, RE2, RE3, RE4 antes de receber os novos valores
    or      $t1, $t1, $s1         # set RE1, RE2, RE3, RE4
    sw      $t1, LATE($s0)


    li      $v0, RESET_CORE_TIMER
    syscall
wait:
    li      $v0, READ_CORE_TIMER
    syscall
    blt     $v0, 1000000, wait      # frequencia de icremento de 1.5hz do ex (13 333 333)

    lw      $t1, PORTB($s0)      # read the current value of PORTB
    andi    $t1, $t1, 0x0001     # set RB0
    
if:
    beq     $t1, $zero, else

    xori    $t4, $s1, 0x0008       
    srl     $t4, $t4, 3            
    sll     $s1, $s1, 1            
    andi    $s1,$s1,0x000F         
    or      $s1,$s1,$t4
    j       loop
else:
    xori    $t3, $s1, 0x0001       # inverte o valor de s1
    sll     $t3, $t3, 3
    srl     $s1, $s1, 1 
  #  andi    $s1, $s1, 0x000F     # como $s1 sofreu um srl, não necessita de ser aplicada mascara, uma vez que os bits menos significativos estão intactos
    andi    $t3, $t3, 0x000F       # no caso de $t3, é necessário aplicar a mascara, pois é feito um sll, e os bits menos significativos são alterados
    or      $s1, $s1, $t3
    j       loop



    lw      $ra, 0($sp)            
    lw      $s0, 4($sp)            
    lw      $s1, 8($sp)            
    addiu   $sp, $sp, 12          
    jr      $ra   
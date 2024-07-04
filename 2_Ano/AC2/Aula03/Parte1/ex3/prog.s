	.equ ADDR_BASE_HI, 0xBF88
	.equ TRISE, 0x6100
	.equ PORTE, 0x6110
	.equ LATE, 0x6120
	.equ TRISD, 0x60C0
	.equ PORTD, 0x60D0
	.equ LATD, 0x60E0
	.data
	.text
	.globl main
main:
	lui		$t1,ADDR_BASE_HI
	
	lw 		$t2,TRISE($t1)		# READ (mem_addr = 0xF88 + 0X6100
	andi	$t2,$t2, 0xFFFE		# colocar RE0 a 0 (saída)
	sw 		$t2,TRISE($t1)		# WRITE 
	
	lw		$t2,TRISD($t1)
	ori		$t2,$t2,0x0100
	sw		$t2,TRISD($t1)

while:
	lw		$t2,PORTD($t1)		# $t2 = [PORTD]
	andi	$t2,$t2,0x0100		# $t2 = RD8
    srl     $t2,$t2,8			# $t2 = RD0
	
	lw		$t3,LATE($t1)		# $t3 = [LATE]
	andi	$t3,$t3,0xFFFE		# RE0 = 0
	or		$t3,$t3,$t2			# RE0 = RD8
	sw		$t3,LATE($t1)		#
	
	j		while
	
	li		$v0,0
	jr		$ra
	
	

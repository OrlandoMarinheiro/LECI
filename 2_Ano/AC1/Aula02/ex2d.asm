	.data
	.text
	.globl main
main: 	ori $t0,$0,5
	
	srl $t1,$t0,1	#deslocamento para a direta de 1 bit
	xor $t1,$t1,$t0  #xor 
	
	jr $ra
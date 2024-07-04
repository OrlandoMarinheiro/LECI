	.data
	.text
	.globl main
main: 	ori $t0,$0,3		# $t0 =  
	or $t1,$0,$t0
	#or $t2,$0,$8		# $t9 = $8
	
	srl $t2,$t2,4	# $t9 = $t9 >> 4
	xor $t1,$t1,$t2	# $t8 = $t8 ^ $t9 (xor)
	
	srl $t2,$t2,2		# $t9 = $t9 >> 2
	xor $t1,$t1,$t2	# $t8 = $t8 ^ $t9 (xor)
	
	srl $t2,$t2,1		# $t9 = $t9 >> 1
	xor $t1,$t1,$t2	# $t8 = $t8 ^ $t9 (xor)
		
	or $t2,$0,$t1		# $t9 = $t8 -> bin 

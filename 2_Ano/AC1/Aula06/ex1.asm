#mapa de registos
# $t0 -> i 
# st1 -> array + SIZE
# $t2 -> array
		.data
  	.eqv SIZE, 3
str1:  	.asciiz "Array"
str2:  	.asciiz "de"
str3:  	.asciiz "ponteiros"
array: 	.word str1, str2, str3
 	.eqv print_string, 4
  	.eqv print_char, 11    
	.text
	.globl main
main:
  	li $t0, 0      # i = 0
  	la $t2, array  # inicializar o array
for:  
	bge $t0, SIZE, endfor  # i < SIZE
	
  	mul $t1, $t0, 4    # i*4
  	addu $t1, $t1, $t2 	# array + i * 4
  	
  	lw $a0, 0($t1)  # $a0 fica com o valor de $t1
  	li $v0, print_string
  	syscall

  	li $v0, print_char
  	li $a0, '\n'
  	syscall

  	addiu $t0, $t0, 1  # i++
	j for
endfor:
  	jr $ra

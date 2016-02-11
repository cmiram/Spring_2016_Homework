.text

main:
	li $t0, 3
	li $t1, 5
	blt $t0, $t1, label
	addi $t5, $t4, 3
	addi $t3, $t4, 3
	addi $t3, $t4, 3
label:	j main
	li $v0, 10
	syscall
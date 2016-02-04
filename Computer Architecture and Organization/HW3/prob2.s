.data
sumString:
	.asciiz "5 + 33 = "
diffString:
	.asciiz "\n5 - 33 = "
storedInts:
	.word 5, 33
sumAndDifference:
	.space 8
	
.text
main:
	la $t0, storedInts #load address of stored ints
	lw $t1, 0($t0) #load first int
	lw $t2, 4($t0) #load second int
	add $t3, $t1, $t2 #z = x + y
	sub $t4, $t1, $t2 #z = x - y
	la $t0, sumAndDifference #load address of data block to store values
	sw $t3, 0($t0) #store sum in first 4 bytes of sumAndDifference
	sw $t4, 4($t0) #store difference in last 4 bytes
	la $t0, sumString #load address of sumString
	move $a0, $t0 #set arg register to string address for syscall
	li $v0, 4 #value for print_string syscall
	syscall
	move $a0, $t3 #move return of sum into arg for print_int syscall
	li $v0, 1 #print_int syscall code
	syscall
	la $t0, diffString #load address of difference string
	move $a0, $t0 #move string address to arg register for syscall
	li $v0, 4 #print_string syscall
	syscall
	move $a0, $t4 #set arg register to differenec calculated for syscall
	li $v0, 1 #print_int syscall
	syscall
	li $v0, 10 #value for exit syscall
	syscall
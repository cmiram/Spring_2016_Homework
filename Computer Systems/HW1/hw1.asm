#read in an int and calculate the factorial of it
	.data
	#request_input = "Positive integer: "
request_input: .asciiz "Positive integer: " #string used to ask user for input
	#return_output = "The factorial of this is: "
return_output: .asciiz "The factorial of this is: " #string to return the factorial to the user

.text

main: #main function
	la $a0, request_input #load address for requesting input into register a0
	li $v0, 4 #load 4 into v0 because it is the syscall code for print_string
	syscall #system call for print_string
	li $v0, 5 #load syscall code for read_int
	syscall #calls read_int to ask user for input
	move $t0, $v0 #move user input into temporary variable register
	move $a0, $t0 #move input into arg-register for factorial routine
	sw $t0, 0($sp) #store starting value
	sw $ra, 8($sp) #store ra
	jal fact #call factorial routine
	lw $t1, 4($sp) #load factorial solution
	la $a0, return_output #loads return output string into a0 for system call
	li $v0, 4 #loads in 4 for syscall which is print_string
	syscall #prints return string
	la $a0, ($t1) #load in factorial return into a0 for print_int
	li $v0, 1 #loads in syscall code 1 for print_int
	syscall #calls print_int
	li $v0, 10 #loads in syscall for exit
	syscall #exit
	
######### end main routine

#routine to calculate factorial of input
	.data
	.text
fact:	lw $t0, 0($sp) #x
	beq $t0, 0, retOne #if(x = 0) goto retOne
	addi $t0, $t0, -1 #x - 1
	addi $sp, $sp, -12 #move stack 12 bits
	sw $ra, 8($sp) #sp[2] = ra
	sw $t0, 0($sp) #sp[0] = x
	jal fact
	lw $ra, 8($sp) #ra = sp[2]
	lw $t1, 4($sp) #x
	lw $t2, 12($sp) #fact(x-1)
	mul $t3, $t1, $t2 #x * fact(x-1)
	addi $sp, $sp, 12 #move stack back
	sw $t3, 4($sp) #sp[4] = x * fact(x-1)
	jr $ra
	
retOne: li $t0, 1 #t0 = 1
	sw $t0, 4($sp) #sp[3] = 1
	jr $ra #return
	
######### end factorial routine

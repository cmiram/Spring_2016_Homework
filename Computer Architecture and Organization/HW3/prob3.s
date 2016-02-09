.data
inputString:
	.asciiz "Input string to conver to int: "
convertedString:
	.asciiz "Your input converted to an int is: "
userString:
	.space 32

.text
main:
	la $a0, inputString #load string to ask user for input
	li $v0, 4
	syscall
	la $a0, userString #load address of location to store user's input
	li $a1, 32 #read in at most 32 bytes
	li $v0, 8 #code for read string
	syscall
	jal ConvertToInt #convert user input to int
	move $t0, $v0 #set t0 to int value of return
	la $a0, convertedString #load address of converted string output
	li $v0, 4 #syscall code for print string
	syscall
	move $a0, $t0 #load int conversion to arg0
	li $v0, 1 #syscall code for print int
	syscall
	li $v0, 10 #exit syscall
	syscall
	
ConvertToInt:
	la $t0, userString #load address of user input
	lb $t1, 0($t0) #load first byte
	li $t3, 0 #total
	beq $t1, 45, negativeConversion #if first char is '-' resultant number will be negative
positiveConversion:
	blt $t1, 48, nonNumber #char is less than '0' return -1
	bgt $t1, 57, nonNumber #char is greater than '9' return -1
	add $t1, $t1, -48 #set char to numerical value
	add $t3, $t3, $t1 #add value to toal
	addi $t0, $t0, 1 #move over 1 byte in user input
	lb $t1, 0($t0) #load byte
	beq $t1, 10, endConversion #if next char is null end loop
	mul $t3, $t3, 10 #multiply total by 10
	j positiveConversion
endConversion:
	move $v0, $t3 #load return value
	jr $ra #return to main
		
negativeConversion:
	addi $t0, $t0, 1 #move over 1 byte
	lb $t1, 0($t0) #load first numerical byte
conversionLoop:
	blt $t1, 48, nonNumber #char is less than '0' return -1
	bgt $t1, 57, nonNumber #char is greater than '9' return -1
	add $t1, $t1, -48 #set char to numerical value
	add $t3, $t3, $t1 #add value to toal
	addi $t0, $t0, 1 #move over 1 byte in user input
	lb $t1, 0($t0) #load byte
	beq $t1, 10, endConversionNeg #if next char is null end loop
	mul $t3, $t3, 10 #multiply total by 10
	j conversionLoop
endConversionNeg:
	mul $t3, $t3, -1 #negate return value
	move $v0, $t3 #put return value in register
	jr $ra

nonNumber:
	li $v0, -1 #return -1 if non-number char is detected
	jr $ra

.data

stringInputPrompt:
	.asciiz "Enter string: "
stringOutputResult:
	.asciiz "New string: "

strInput:
	.space 100
strModified:
	.space 100

.text
main:
	la $a0, stringInputPrompt #load addr of prompt to input string
	li $v0, 4 #syscall code for print_string
	syscall
	la $a0, strInput #load addr of space to store user input
	li $a1, 100 #max chars to read
	li $v0, 8 #syscall code for read_string
	syscall
	la $t0, strInput #addr of user input
	la $t1, strModified #load addr of space to put modified string
removeSpaceLoop:
	lb $t2, ($t0) #s[i]
	beq $t2, 32, skipStore #if(s[i] == ' ') goto skipStore
	sb $t2, ($t1) #store s[i] in strModified space
	addi $t1, $t1, 1 #increment strModified addr by 1 byte
	beqz $t2, endLoop #if(s[i] == '\0') goto endLoop
skipStore:
	addi $t0, $t0, 1 #increment s[i] by 1 byte
	j removeSpaceLoop #continue loop
endLoop:
	la $a0, stringOutputResult #load addr of prompt to output modified string
	li $v0, 4 #syscall code for print_string
	syscall
	la $a0, strModified #load addr of modified string
	li $v0, 4 #syscall code for print_string
	syscall
	li $v0, 10 #exit
	syscall
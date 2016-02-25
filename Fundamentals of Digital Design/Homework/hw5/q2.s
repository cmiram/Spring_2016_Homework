.data
prompt: .asciiz "Enter a string: "
replyLower: .asciiz "The first character is a lower-case letter\n"
replyNotLower: .asciiz "The first character is not a lower-case letter\n"
userString: .space 20

.text

main:
	la $a0, prompt #load address of string to prompt user
	li $v0, 4 #sys call code for print_string
	syscall
	la $a0, userString #address of memory to store user input
	li $a1, 20 #max chars to read from user input
	li $v0, 8 #read_string sys call code
	syscall
	lb $t0, userString #load first char of user input string
	blt $t0, 97, notLower #if(str[0] < 'a') goto upperCase
	bgt $t0, 122, notLower #if(str[0] > 'z') goto upperCase
	la $a0, replyLower #load address of lower case instance reply
	li $v0, 4 #sys call code for print_string
	syscall
	j endMain
notLower:
	la $a0, replyNotLower #load address of upper case instance reply
	li $v0, 4 #syscall code for print_string
	syscall
endMain:
	li $v0, 10 #exit
	syscall
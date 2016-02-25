.data
prompt: .asciiz "Enter your name: "
reply: .asciiz "Hello, "
nameBuffer: .space 100

.text

main:
	la $a0, prompt #load address of prompt string into t0
	li $v0, 4 #set v0 to 4 for print_string sys call
	syscall #print_string syscall
	la $a0, nameBuffer #load address of location to store the string input
	li $a1, 20 #max number of chars to read
	li $v0, 8 #code for read_string syscall
	syscall
	la $a0, reply #load address of reply string
	li $v0, 4 #print_string sys call code
	syscall
	la $a0, nameBuffer #load address of user input string
	li $v0, 4 #print_string syscall
	syscall
	li $v0, 10 #exit
	syscall
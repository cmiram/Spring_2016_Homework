.data

inputPromptStr1:
	.asciiz "Enter string 1: "
inputPromptStr2:
	.asciiz "Enter string 2: "

outputPromptS1Greater:
	.asciiz "s1 > s2\n"
outputPromptS1Less:
	.asciiz "s1 < s2\n"
outputPromptEqual:
	.asciiz "The strings are equal\n"
	
strInput1: .space 100
strInput2: .space 100

.text
main:
	la $a0, inputPromptStr1 #load addr of input prompt for str 1
	li $v0, 4 #syscall code for print_string
	syscall
	la $a0 strInput1 #addr to store input string to
	li $a1, 100 #max chars to read
	li $v0, 8 #syscall code for read_string
	syscall
	la $a0, inputPromptStr2 #load addr of input prompt for string 2
	li $v0, 4 #syscall code for print_string
	syscall
	la $a0, strInput2 #addr to store string input 2
	li $a1, 100 #max chars to read
	li $v0, 8 #syscall code for read_string
	syscall
	la $t0, strInput1 #s1
	la $t1, strInput2 #s2
whileLoop:
	lb $t2, ($t0) #s1[i]
	lb $t3, ($t1) #s2[i]
	bgt $t2, $t3 s1Greater #if(s1[i] > s2[i]) goto s1Greater
	blt $t2, $t3, s1Less #if(s1[i] < s2[i]) goto s1Less
	beqz $t2, strEqual #if(s1[i] == '\0') goto strEqual
	addi $t0, $t0, 1 #s1 addr plus 1 byte
	addi $t1, $t1, 1 #s2 addr plus 1 byte
	j whileLoop
s1Greater:
	la $a0, outputPromptS1Greater #load addr of output string for s1 > s2
	li $v0, 4 #syscall code for print_string
	syscall
	j endLoop #end loop
s1Less:
	la $a0, outputPromptS1Less #load addr of output string for s1 < s2
	li $v0, 4 #syscall code for print_string
	syscall
	j endLoop #end loop
strEqual:
	la $a0, outputPromptEqual #load addr of output string for s1 == s2
	li $v0, 4 #syscall code for print_string
	syscall
endLoop:
	li $v0, 10 #syscall code for exit
	syscall

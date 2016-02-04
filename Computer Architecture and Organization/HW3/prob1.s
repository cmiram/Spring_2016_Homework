.data
myName:
	.asciiz "Name: Chris Miramontes\n"
favTeam:
	.asciiz "Favorite Team: Carolina Panthers"

.text
main:
	la $t0, myName #load address of name string
	la $t1, favTeam #load address of team name
	move $a0, $t0 #put name address into arg0 for syscall
	li $v0, 4 #value for print_string syscall
	syscall
	move $a0, $t1 #load arg for syscall
	li $v0, 4 #print string syscall code
	syscall
	li $v0, 10 #arg for exit syscall
	syscall
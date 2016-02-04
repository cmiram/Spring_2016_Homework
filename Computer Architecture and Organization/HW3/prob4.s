# Compute factorial of a number and print
.data
prompt: .asciiz "Please input a non-negative integer number for computation.\n"
.text

# user inputs the number 
main:  
     la   $a0, prompt# load address of prompt for syscall
     li   $v0, 4     # specify system service of Print String
     syscall         # print the prompt string
     li   $v0, 5     # specify system service of Read Integer
     syscall         # Read the number. After this instruction, the number read is in $v0.
     blt  $v0, $zero, main   # Check if the input is a positive integer
     move $v0, $s3 #store input
     add  $a0, $v0, $zero  # transfer the number to the desired register
      
     jal fact #you should change this function call to your specific names

     #the factorial number is computed and stored in $v0, copy it to $a1, the original number is in $a0, print both of them them out
     move $a0, $s3
     add $a1, $zero, $v0    # second argument for print, the result
     jal  print            # call print routine. 

     # The program is finished. Exit.
     li   $v0, 10          # system call for exit
     syscall               # Exit!
     
fact:
	move $s0, $a0 #x -> load arg into register
	beqz $s0, returnOne #if (x==0) return 1
	addi $s0, $s0, -1 #x = x - 1
	addi $sp, $sp, -12 #move stack over 12
	sw $s0, 0($sp) #store x at beginning of stack
	sw $ra, 4($sp) #store return address at sp[1]
	move $a0, $s0 #move x-1 to arg0 and make recursive call to fact
	jal fact
	lw $ra, 4($sp) #restore return address
	lw $s0, 0($sp) #restore x
	lw $t0, 12($sp) #fact(x-1)
	mul $t1, $s0, $t0 #x * fact(x-1)
	addi $sp, $sp, 12 #move stack back
	sw $t1, 12($sp) #store x * fact(x-1)
	move $v0, $t1
	jr $ra #follow return address
returnOne:
	li $t0, 1 #return value
	sw $t0, 12($sp) #store return value
	jr $ra #follow return address

###############################################################
# Subroutine to print the given number and its factorial.
.data
head: .asciiz  "The given number is: " 
head2: .asciiz "; Its Factorial is: "

.text
print: add  $t0, $zero, $a0  # the orignal number
      add  $t1, $zero, $a1   # the computed result

      la   $a0, head        # load address of the print heading string
      li   $v0, 4           # specify Print String service
      syscall               # print the heading string
      
      add   $a0, $zero, $t0 # load the integer to be printed (the current Fib. number)
      li   $v0, 1           # specify Print Integer service
      syscall               # print original number
      
      la   $a0, head2        # load address of the print heading string
      li   $v0, 4           # specify Print String service
      syscall               # print the heading string
      
      add   $a0, $zero, $t1      # load the integer to be printed (the factorial number)
      li   $v0, 1           # specify Print Integer service
      syscall               # print the result
      
      jr   $ra              # return from subroutine
# End of subroutine to print the numbers on one line
###############################################################



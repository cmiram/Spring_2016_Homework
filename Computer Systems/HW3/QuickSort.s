	.data
arrayOfNames:	
	.align 2
	.asciiz "Joe\0"
	.align 2
	.asciiz  "Jenny"
	.align 2
	.asciiz "Jill"
	.align 2
	.asciiz "John"
	.align 2
	.asciiz "Jeff"
	.align 2
	.asciiz "Joyce"
	.align 2
	.asciiz "Jerry"
	.align 2
	.asciiz "Janice"
	.align 2
	.asciiz "Jake"
	.align 2
	.asciiz "Jonna"
	.align 2
	.asciiz "Jack"
	.align 2
	.asciiz "Jocelyn"
	.align 2
	.asciiz "Jessie"
	.align 2
	.asciiz "Jess"
	.align 2
	.asciiz "Janet"
	.align 2
	.asciiz "Jane"
ptrToNames: 
	.align 2 
	.space 64
numNames: 
	.word 16
newLine:
	.asciiz "\n"
space:
	.asciiz " "

.text

main:
	jal initPtrs
	jal printArray
	li $a0, 0 #first
	li $a1, 15 #last
	jal quickSort
	jal printArray
	li $v0, 10 #loads in syscall for exit
	syscall #exit
	
initPtrs:
	la $t0, arrayOfNames #load address of names array
	la $t1, ptrToNames #load address of pointer array
	move $t3, $zero #i
ptrLoop:
	sw $t0, ($t1) #t1 = t0
	addi $t0, $t0, 8 #t0 = t0 + 8
	addi $t1, $t1, 4 #t1 = t1 + 4
	addi $t3, $t3, 1 #i++
	bne $t3, 16, ptrLoop
	jr $ra
	
quickSort:
	move $s0, $a0 #first
	move $s1, $a1 #last
	move $t0, $s0 #i
	move $t1, $s1 #j
	add $t2, $t0, $t1 #x = i + j
	srl $t2, $t2, 1 #x = x / 2 -> avg of i and j
	la $t3, ptrToNames #a
	mul $t2, $t2, 4 #x * 4
	add $t2, $t3, $t2 #x = address of a[x]
	lw $t2, ($t2) #x = a[x]
qsFor:
iWhile:
	mul $t4, $t0, 4 #i * 4
	add $t4, $t3, $t4 #y = address of a[i]
	lw $t4, ($t4) #y = a[i]
	move $a0, $t4  #str_lt arg0 = a[i]
	move $a1, $t2 #str_lt arg1 = x
	sw $ra ($sp) ##save ra to main
	sw $t0, 4($sp) #save i
	sw $t1, 8($sp) #save j
	sw $t2, 12($sp) #save x
	sw $t3, 16($sp) #save a
	addi $sp, $sp, -16 #move sp 16
	jal str_lt
	addi $sp, $sp, 16 #move sp 16
	lw $ra ($sp) ##save ra to main
	lw $t0, 4($sp) #restore i
	lw $t1, 8($sp) #restore j
	lw $t2, 12($sp) #restore x
	lw $t3, 16($sp) #restore a
	move $t5, $v0 #str_lt return value
	beqz $t5, jWhile #if (str_lt == 0) jump to next while loop
	addi $t0, $t0, 1 #i++
	j iWhile #loop again
jWhile:
	mul $t4, $t1, 4 #j * 4
	add $t4, $t3, $t4 #y = address of a[j]
	lw $t4, ($t4) #y = a[j]
	move $a0, $t2 #str_lt arg0 = x
	move $a1, $t4 #str_lt arg1 = a[j]
	sw $ra ($sp) ##save ra to main
	sw $t0, 4($sp) #save i
	sw $t1, 8($sp) #save j
	sw $t2, 12($sp) #save x
	sw $t3, 16($sp) #save a
	addi $sp, $sp, -16 #move sp 16
	jal str_lt
	addi $sp, $sp, 16 #move sp 16
	lw $ra ($sp) ##save ra to main
	lw $t0, 4($sp) #restore i
	lw $t1, 8($sp) #restore j
	lw $t2, 12($sp) #restore x
	lw $t3, 16($sp) #restore a
	move $t5, $v0 #return value of str_lt
	beqz $t5, endJWhile #if (str_lt == 0) end jWhile loop
	addi $t1, $t1, -1 #j--
	j jWhile #continue jWhile loop
endJWhile:
	bge $t0, $t1, breakForLoop #if (i >= j) break out of qsForLoop
	mul $t4, $t0, 4 #i * 4
	add $t4, $t3, $t4 #t4 = address of a[i]
	lw $t5, ($t4) #t = a[i]
	mul $t6, $t1, 4 #j * 4
	add $t6, $t3, $t6 #address of a[j]
	lw $t7, ($t6) #a[j]
	sw $t7, ($t4) #a[i] = a[j]
	sw $t5, ($t6) #a[j] = t
	addi $t0, $t0, 1 #i++
	addi $t1, $t1, -1 #j--
	j qsFor #continue for loop
breakForLoop:
	addi $t8, $t0, -1 #i - 1
	sw $ra ($sp) ##save ra to main
	sw $t0, 4($sp) #save i
	sw $t1, 8($sp) #save j
	sw $t2, 12($sp) #save x
	sw $s0, 16($sp) #save first
	sw $s1, 20($sp) #save last
	addi $sp, $sp, -24 #move sp 24
	bge $s0, $t8, skipIRecursion #if (first > (i-1)) skip recursive call
	move $a0, $s0 #arg0 = first
	move $a1, $t8 #arg1 = i - 1
	jal quickSort
skipIRecursion:
	addi $sp, $sp, 24 #move sp 24
	lw $ra ($sp) ##save ra to main
	lw $t0, 4($sp) #restore i
	lw $t1, 8($sp) #restore j
	lw $t2, 12($sp) #restore x
	lw $s0, 16($sp) #restore first
	lw $s1, 20($sp) #restore last
	addi $t8, $t1, 1 #j + 1
	bgt $t8, $s1, skipJRecursion #if ((j+1) >= last) skipJRecursion
	sw $ra ($sp) ##save ra to main
	sw $t0, 4($sp) #save i
	sw $t1, 8($sp) #save j
	sw $t2, 12($sp) #save x
	sw $s0, 16($sp) #save first
	sw $s1, 20($sp) #save last
	addi $sp, $sp, -24 #move sp 24
	move $a0, $t8 #arg0 = j + 1
	move $a1, $s1 #last
	jal quickSort
skipJRecursion:
	addi $sp, $sp, 24 #move sp 24
	lw $ra ($sp) ##restore ra to main
	lw $t0, 4($sp) #restore i
	lw $t1, 8($sp) #restore j
	lw $t2, 12($sp) #restore x
	lw $s0, 16($sp) #restore first
	lw $s1, 20($sp) #restore last
	jr $ra
	
str_lt:
	la $t2, ($a0) #string data in a[i]
	la $t3, ($a1) #string data in a[j]
	lb $t4, ($t2) #first char in a[i] string
	lb $t5, ($t3) #first char in a[j] string
strLtFor:
	add $t6, $t4, $t5 #t3 = sum of chars
	beqz $t6, endLtFor #end for if both chars are '\0'
	blt $t4, $t5, aILessThan #a[i] < a[j]
	blt $t5, $t4, aJLessThan #a[j] < a[i]
	addi $t2, $t2, 1 #increment 1 char in a[i]
	addi $t3, $t3, 1 #increment 1 char in a[j]
	lb $t4, ($t2) #load char into t2
	lb $t5, ($t3) #load char into t3
	j strLtFor #continue loop
aILessThan:
	li $v0, 1 #return 1
	jr $ra #return to place in jLoop
aJLessThan:
	li $v0, 0 #return 0
	jr $ra #return to place in jLoop
endLtFor:
	sgt $v0, $t5, 0 #if(t3 > 0) return 1 else return 0
	jr $ra #return to place in jLoop
	
printArray:
	move $t3, $zero #i
	la $t0, ptrToNames #*x
printLoop:
	lw $a0, ($t0) #load arg register
	li $v0, 4 #print string syscall
	syscall
	la $a0, space #add space between names
	li $v0, 4 #print string syscall
	syscall
	addi $t0, $t0, 4 #*x++
	addi $t3, $t3, 1 #i++
	bne $t3, 16, printLoop
	la $a0, newLine #add new line between names
	li $v0, 4 #print string syscall
	syscall
	jr $ra #return to main

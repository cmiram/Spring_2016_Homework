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
	jal insertSort
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
	
insertSort:
	li $s0, 0 #i
	addi $s1, $s0, -1 #j
	la $s3, ptrToNames
iLoop:
	addi $s0, $s0, 1 #i++
	beq $s0, 16, endILoop
	addi $s1, $s0, -1 #j = i - 1
	mul $t6, $s0, 4 #i * 4
	add $t6, $t6, $s3 #ptrToNames[i]
	lw $s6, ($t6) #follow pointer in ptrToNames[i]
jLoop:
	bltz $s1, endJLoop #branch if j < 0
	mul $t6, $s1, 4 #j * 4
	add $t1, $t6, $s3 #t1 = ptrToNames[j]
	lw $t1, ($t1) #follow pointer in ptrToNames[j]
	move $a0, $s6 #value in C-Code
	move $a1, $t1 #arrayOfNames[j]
	sw $ra, ($sp) #save return address to main
	jal str_lt
	lw $ra, ($sp) #load return address to main
	move $s7, $v0 #get return value of str_len
	beqz $s7, endJLoop #if str_len = 0 end loop; otherwise continue
	addi $t3, $s1, 1 #t3 = j+1
	mul $t3, $t3, 4 #(j+1) * 4
	add $t4, $s3, $t3 #t4 = ptrToNames[j+1]
	mul $t6, $s1, 4 #j * 4
	add $t7, $s3, $t6 #t7 = ptrToNames[j]
	lw $t7, ($t7) #follow pointer to string address
	sw $t7, ($t4) #ptrToNames[j+1] = ptrToNames[j]
	addi $s1, $s1, -1 #j--
	j jLoop
endJLoop:
	addi $s1, $s1, 1 #j = j + 1
	mul $s1, $s1, 4 #j * 4
	add $t4, $s3, $s1 #t4 = ptrToNames[j+1]
	mul $t5, $s0, 8 #i * 4
	sw $s6, ($t4) #ptrToNames[j+1] = value
	j iLoop
endILoop:
	jr $ra #return to main

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
clr $0
clr $1
clr $2
clr $3
sw $3, 0x3($3)
addi $0, $0, 0xFE
addi $1, $1, 0x11
sw $0, 0x1($2)
sw $1, 0x2($2)
andi $2, $0, 0x80
beq $2, $3, CHK_SG
inv $0, $0
addi $0, $0, 0x1
CHK_SG: 
andi $2, $1, 0x80
beq $2, $3, mult_loop
inv $1, $1
addi $1, $1, 0x1
mult_loop: 
andi $2, $1, 0x1
beq $2, $3, bit_clear
clr $2
lw $3, 0x3($2)
add $3, $3, $0
sw $3, 0x3($2)
clr $3
bit_clear: 
sll $0, $0, 0x1
sra $1, $1, 0x1
bne $1, $2, mult_loop
lw $0, 0x1($2)
lw $1, 0x2($2)
andi $0, $0, 0x80
andi $1, $1, 0x80
inv $2, $0
and $2, $1, $2
inv $3, $1
and $3, $0, $3
or $2, $2, $3
clr $0
lw $3, 0x3($0)
beq $2, $0, DONE
inv $3, $3
addi $3, $3, 0x1
DONE: 
addi $3, $3, 0x0
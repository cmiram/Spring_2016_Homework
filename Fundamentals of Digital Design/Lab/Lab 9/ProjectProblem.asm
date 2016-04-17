clr $0
clr $1
clr $2
clr $3
addi $0, $0, 16
summationLoop: 
lw $2, 0($1)
add $3, $3, $2
addi $1, $1, 1
bne $1, $0, summationLoop
sra $3, $3, 1
sra $3, $3, 1
sra $3, $3, 1
sra $3, $3, 1
addi $3, $3, 0
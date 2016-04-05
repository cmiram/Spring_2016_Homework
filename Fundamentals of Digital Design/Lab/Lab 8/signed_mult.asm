main:
    clr $0
    clr $1
    clr $2
    clr $3
    ori $1, $1, -7
    ori $2, $2, 3
    or $3, $1, $2
    sra $3, $3, 7
    beq $3, $0, posResult
    and $3, $1, $2
    sra $3, $3, 7
    beq $3, $0, negResult
posResult:
    andi $1, $1, 0x7f
    andi $2, $2, 0x7f
    beq $0, $0, multLoop
negResult:
    andi $3, $3, 0x80
    andi $1, $1, 0x7f
    andi $2, $2, 0x7f
multLoop:
    add $3, $3, $1
    addi $2, $2, -1
    bne $2, $0, multLoop
endFunct:
    
.text
main:
    #assumed $1 $2 are the operands
    #assumed output will be $3
    clr $3
    or $3, $1, $2
    sra $3, $3, 7
    beq $3, $0, posResult
    and $3, $1, $2
    sra $3, $3, 7
    beq $3, $0, negResult
posResult:
    andi $1, $1, 0x7f
    andi $2, $2, 0x7f
posLoop:
    
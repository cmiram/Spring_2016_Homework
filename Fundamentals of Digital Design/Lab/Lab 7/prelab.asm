clr $0
clr $1
addi $1, $1, 0xFE
sw $1, 0x9($0)
clr $1
addi $1, $1, 0x11
sw $1,  0x10($0)
lw $1, 0x9($0)
ori $1, $1, 0x80
sw $1, 0x11($0)
lw $1, 0x10($0)
ori $1, $1, 0x80
sw $1, 0x12($0)
lw $1, 0x11($0)
lw $2, 0x12($0)
add $1, $1, $2
sw $1, 0x13($0)
lw $1, 0x9($0)
inv $1, $1
addi $1, $1, 0x01
sw $1, 0x14($0)
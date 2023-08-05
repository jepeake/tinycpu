.text
init:
    addi    a0, zero, 0x0       # a0 is used for output
    addi    t1, zero, 0x0       # set t1 to zero
    addi    a1, zero, 0x0       # a1 init to 0
loop:
    addi    t1, t1, 0xA         # inc t1 with 10
    jal     ra, inc             # jump to inc subroutine
    j       loop
inc:
    addi    a0, a1, 0           # load a0 with a1
    addi    a1, a1, 1           # increment a1
    bne     a1, t1, inc         # if a1 != t1, branch to inc
    addi    a0, a1, 0           # load a0 with a1
    ret
    
.text
.globl main
main:
    addi    t1, zero, 0x3FC     # load t1 with 1020  (4X255)
    addi    a0, zero, 0x0       # a0 is used for output
mloop:     
    addi    a1, zero, 0x0       # a1 is the counter, init to 0
iloop:
    lw      a0, 0(a1)           # load a0 dmem[a1]
    addi    a1, a1, 0x4         # increment a1
    bne     a1, t1, iloop       # if a1 != 1020, branch to iloop
    bne     t1, zero, mloop     #  ... else always brand to mloop

.text
#memory needs to be mapped correctly
main:
    jal     ra, init           # execute init subroutine
loop:
    jal     ra, reset          # execute reset subroutine
    jal     ra, shift          # execute shift subroutine
    j       loop               # loop forever
init:
    addi    t1, zero, 0xFF     # load t1 with 255
    ret
reset:
    addi    a0, zero, 0x0      # a0 used for output
    addi    a1, zero, 0x1      # set a1 to 1
    ret
shift:
    addi    a0, a1, 0          # load a0 with a1 
    slli    a1, a1, 1          # shift a1 left by 1 bit
    addi    a1, a1, 1          # increment a1 by 1
    bne     a1, t1, shift      # if a1 !=255, branch to shift
    addi    a0, a1, 0          # load a0 with a1 
    ret         

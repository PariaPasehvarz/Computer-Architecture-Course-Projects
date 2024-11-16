.global _boot

.text
_boot:
    jal x0, find_max          # jump to find_max function

find_max:
    lw   x1, 1000(x0)         # load the initial maximum element
    add  x2, x0, x0           # initialize the loop index to 0

loop:
    addi x2, x2, 4            # increment the loop index
    slti x3, x2, 40           # check if 10 elements are traversed
    beq  x3, x0, end_loop     # if 10 elements are traversed, exit loop
    lw   x4, 1000(x2)         # load the next element
    sltu x5, x1, x4           # compare with the current maximum element
    beq  x5, x0, loop         # if not greater, continue loop
    add  x1, x4, x0           # update the maximum element
    jal  x0, loop             # jump back to loop

end_loop:
    sw x1, 2000(x0)           # store the maximum element
    jal x0, end               # return

end:

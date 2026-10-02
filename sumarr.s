.section .data

Numbers:
    .long 1
    .long 15
    .long 4
    .long 2
    .long 7
    .long 9
    .long 23
    .long 7
    .long 3
    .long 11

Array_length:
    .long 10

.section .text
.globl main

main:
    movl Numbers, %eax
    movl $0x04, %ecx

    

while:
    movl Numbers(%ecx), %edx

    cmpl %eax, %edx
    jle next

    movl %edx, %eax

next:
    addl $0x04, %ecx

    cmpl $0x28, %ecx
    jl while

done:
    ret
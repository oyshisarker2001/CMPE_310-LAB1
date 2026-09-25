.section .text

.global sum_array


sum_array:

mov $0, %eax 

loop:
    add (%rdi), %eax      

    add $4, %rdi         

    dec %rsi             

    jne loop            

    ret


.section .note.GNU-stack,"",@progbits


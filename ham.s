.section .data

prompt1:
 .asciz "Enter the first string: "
 .byte 10,0
prmpt1_len=. - prompt1

prompt2:
 .asciz "Enter the first string: "
 .byte 10,0
prmpt2_len=. - prompt2

result:
 .asciz "Hamming distance: "
result_len=.- result

.section .bss
  .lcomm str1,256
  .lcomm str2,256
  .lcomm output,20

.section .text
.global _start 

_start:

mov $1, %rax 
mov $1, %rdi 
mov $prompt1, %rsi 
mov $prmpt1_len, %rdx 
syscall

mov $0, %rax
mov $0, %rdi
mov $str1, %rsi
mov $255, %rdx
syscall

dec %rax
mov %rax, %r8


mov $1, %rax 
mov $1, %rdi 
mov $prompt2, %rsi 
mov $prmpt2_len, %rdx 
syscall


mov $0, %rax
mov $0, %rdi
mov $str2, %rsi
mov $255, %rdx
syscall


dec %rax
mov %rax, %r9


cmp %r9, %r8
jle use_r8

mov %r9, %rcx
jmp init

use_r8:
mov %r8, %rcx 


init:
 mov $str1,%esi
 mov $str2,%edi
 xor %r10d,%r10d


compare:
  cmp $0, %rcx
  je print_result

   xor %eax, %eax
   xor %ebx, %ebx

  movb (%esi) , %al
  movb (%edi) ,%bl

  xor %bl, %al

  popcnt %eax, %eax
  add %eax, %r10d
  
  inc %esi 
  inc %edi 
  dec %rcx 
  jmp compare



print_result: 

    mov %r10d, %eax
    mov $10, %ebx
    xor %edx, %edx
    div %ebx

   

    add $'0', %eax
    add $'0', %edx

    mov %eax, output
    mov %edx, output+1
    mov $10, output+2


    # Print "Hamming distance: "
    mov $1, %rax
    mov $1, %rdi
    mov $result, %rsi
    mov $result_len, %rdx
    syscall


    # Print the answer
    mov $1, %rax
    mov $1, %rdi
    mov $output, %rsi
    mov $3, %rdx
    syscall


    # Exit
    mov $60, %rax
    mov $0, %rdi
    syscall
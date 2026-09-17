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
 mov $str1,%rsi
 mov $str2,%rdi
 xor %r10, %r10


compare:
  cmp $0, %rcx
  je print_result

   xor %rax, %rax
   xor %rbx, %rbx
  
  movb (%rsi) , %al
  movb (%rdi) ,%bl

  xor %bl, %al

  popcnt %rax, %rax
  add %rax, %r10
  
  inc %rsi 
  inc %rdi 
  dec %rcx 
  jmp compare



print_result: 

    mov %r10, %rax
    mov $10, %rbx
    xor %rdx, %rdx
    div %rbx

    # RAX = tens
    # RDX = ones

    add $'0', %al
    add $'0', %dl

    movb %al, output
    movb %dl, output+1
    movb $10, output+2


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
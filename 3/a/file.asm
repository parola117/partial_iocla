section .data
    s db "obf", 0

section .text
extern exported
global main

main:
    push rbp
    mov rbp, rsp

    ; TODO a: Call the obfuscated function with the correct argument(s).
    lea rdi, [rel s]
    call exported

    ; Return 0.
    xor rax, rax
    leave
    ret
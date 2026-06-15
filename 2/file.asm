section .data
    shaorma_str db "shaorma", 0
    eq_str      db "Equal to shaorma", 10, 0
    neq_str     db "Not equal to shaorma", 10, 0
    fmt_b       db "%d, %d", 10, 0
    env_var     db "SHAORMA", 0
    berbecut    db "berbecut", 0
    fmt_c       db "SHAORMA is set to %s", 10, 0
    fmt_scan    db "%19s", 0

section .text
extern printf
extern strcmp
extern setenv
extern getenv
extern scanf
global main

variadic_sum:
    push rbp
    mov rbp, rsp

    mov eax, esi
    add eax, edx
    add eax, ecx
    add eax, r8d
    add eax, r9d

    cmp edi, 6
    je .sum_6
    cmp edi, 7
    je .sum_7
    jmp .sum_end

.sum_6:
    add eax, dword [rbp + 16]
    jmp .sum_end

.sum_7:
    add eax, dword [rbp + 16]
    add eax, dword [rbp + 24]

.sum_end:
    leave
    ret

set_shaorma:
    push rbp
    mov rbp, rsp

    mov rsi, rdi
    lea rdi, [rel env_var]
    mov edx, 1
    call setenv

    leave
    ret

main:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12d, edi
    mov r13, rsi

    cmp r12d, 2
    jl .not_eq

    mov rdi, [r13 + 8]
    lea rsi, [rel shaorma_str]
    call strcmp
    test eax, eax
    jnz .not_eq

    lea rdi, [rel eq_str]
    xor eax, eax
    call printf
    jmp .done_a

.not_eq:
    lea rdi, [rel neq_str]
    xor eax, eax
    call printf

.done_a:

    mov edi, 6
    mov esi, 1
    mov edx, 2
    mov ecx, 3
    mov r8d, 4
    mov r9d, 5
    sub rsp, 8
    push 9
    call variadic_sum
    add rsp, 16
    mov r12d, eax

    mov edi, 7
    mov esi, 1
    mov edx, 2
    mov ecx, 3
    mov r8d, 4
    mov r9d, 5
    push 19
    push 6
    call variadic_sum
    add rsp, 16
    mov r13d, eax

    lea rdi, [rel fmt_b]
    mov esi, r12d
    mov edx, r13d
    xor eax, eax
    call printf

    lea rdi, [rel berbecut]
    call set_shaorma

    lea rdi, [rel env_var]
    call getenv
    lea rdi, [rel fmt_c]
    mov rsi, rax
    xor eax, eax
    call printf

    sub rsp, 32

    lea rdi, [rel fmt_scan]
    mov rsi, rsp
    xor eax, eax
    call scanf

    mov rdi, rsp
    call set_shaorma

    lea rdi, [rel env_var]
    call getenv
    lea rdi, [rel fmt_c]
    mov rsi, rax
    xor eax, eax
    call printf

    add rsp, 32

    pop r13
    pop r12
    xor rax, rax
    leave
    ret
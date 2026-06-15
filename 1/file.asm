%include "printf64.asm"

section .rodata
    bitss db 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0
    pieces db 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1

section .text
extern printf
global main

main:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14

    mov rax, -1
    cmp rax, 5
    jg .done_a

    PRINTF64 `You know your stuff, -1 < 5\n\x0`

.done_a:

    lea rsi, [bitss]
    mov rcx, 16
    xor r12, r12
.parse_bitss:
    shl r12, 1
    movzx rdx, byte [rsi]
    add r12, rdx
    inc rsi
    dec rcx
    jnz .parse_bitss

    movsx r12, r12w

    test r12, r12
    jle .not_pow2
    mov rbx, r12
    dec rbx
    test rbx, r12
    jnz .not_pow2

    PRINTF64 `The number is not a power of 2\n\x0`
    jmp .done_b

.not_pow2:
    PRINTF64 `The number is not a power of 2\n\x0`

.done_b:

    lea rsi, [pieces]
    mov rcx, 16
    xor r13, r13
.parse_pieces:
    shl r13, 1
    movzx rdx, byte [rsi]
    add r13, rdx
    inc rsi
    dec rcx
    jnz .parse_pieces

    movsx r13, r13w

    PRINTF64 `%d\n\x0`, r13

    mov r14, r12
    add r14, r13

    mov rcx, 16
.print_bits:
    mov rax, r14
    shr rax, 15
    and rax, 1
    PRINTF64 `%d\x0`, rax
    shl r14w, 1
    dec rcx
    jnz .print_bits

    PRINTF64 `\n\x0`

    pop r14
    pop r13
    pop r12
    xor rax, rax
    leave
    ret
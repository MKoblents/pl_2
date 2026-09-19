section .data
    %include "colon.inc"
    %include "words.inc"
    
    test1: db "third word", 0
    test2: db "second word", 0
    test3: db "first word", 0
    test4: db "nonexistent", 0
    
    pass_msg: db "PASS", 10
    pass_len: equ $ - pass_msg
    fail_msg: db "FAIL", 10
    fail_len: equ $ - fail_len
    not_found_msg: db " (not found)", 10

section .text
    extern find_word
    extern print_string
    extern exit
    global _start

_start:
    mov rdi, test1
    mov rsi, dict_head
    mov rsi, [rsi]
    call find_word
    test rax, rax
    jz .test1_fail
    
    mov rdi, [rax + 8]
    mov rsi, test1
    call check_string
    jmp .test1_pass
.test1_fail:
    mov rdi, fail_msg
    mov rax, 1
    mov rsi, fail_msg
    mov rdx, fail_len
    syscall
.test1_pass:
    mov rdi, pass_msg
    mov rax, 1
    mov rsi, pass_msg
    mov rdx, pass_len
    syscall

    mov rdi, test4
    mov rsi, dict_head
    mov rsi, [rsi]
    call find_word
    test rax, rax
    jnz .test2_fail

    jmp .test2_pass
.test2_fail:
    mov rdi, fail_msg
    mov rax, 1
    mov rsi, fail_msg
    mov rdx, fail_len
    syscall
.test2_pass:
    mov rdi, pass_msg
    mov rax, 1
    mov rsi, pass_msg
    mov rdx, pass_len
    syscall

    mov rdi, 0
    call exit

check_string:
    xor rax, rax
.loop:
    mov r8b, [rdi + rax]
    mov r9b, [rsi + rax]
    cmp r8b, r9b
    jne .not_equal
    test r8b, r8b
    je .equal
    inc rax
    jmp .loop
.not_equal:
    xor rax, rax
    ret
.equal:
    mov rax, 1
    ret
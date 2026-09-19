section .bss
    buffer resb 256

section .data
    %include "colon.inc"
    %include "words.inc"
    err_not_found: db "Word not found", 10
    len_not_found: equ $ - err_not_found
    err_too_long: db "input is too long", 10
    len_too_long: equ $ - err_too_long

section .text
    global _start
    extern find_word
    extern read_char
    extern print_string
    extern print_newline
    extern exit

_start:
    and rsp, -16
    xor rcx, rcx
    .read_loop:
        push rcx
        call read_char
        pop rcx
        test rax, rax
        jz .read_end
        cmp al, 0xA
        je .read_end
        cmp al, 0xD
        je .read_end   
        cmp rcx, 255
        jge .too_long
        mov [buffer + rcx], al
        inc rcx
        jmp .read_loop
    .read_end:
        mov byte [buffer + rcx], 0
        mov rdi, buffer
        mov rsi, dict_head
        mov rsi, [rsi]
        call find_word
        test rax, rax
        jz .not_found
        mov rdi, [rax + 16]
        call print_string
        call print_newline
        jmp .exit_ok
    .too_long:
        mov rax, 1
        mov rdi, 2
        mov rsi, err_too_long
        mov rdx, len_too_long
        syscall
        jmp .exit_fail
    .not_found:
        mov rax, 1
        mov rdi, 2
        mov rsi, err_not_found
        mov rdx, len_not_found
        syscall
        
    .exit_fail:
        mov rdi, 1
        call exit
        
    .exit_ok:
        xor rdi, rdi
        call exit
section .bss
    buffer resb 256

section .data
    %include "colon.inc"
    %include "words.inc"
    err_msg: db "Word not found", 10
    err_len equ $ - err_msg

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
        cmp rax, 0xA
        jz .read_end
        mov [buffer+rcx], al
        inc rcx
        cmp rcx, 254
        jz .read_end
        jmp .read_loop
    .read_end:
        mov byte [buffer+rcx], 0


    mov rdi, buffer
    mov rsi, dict_head
    mov rsi, [rsi]
    call find_word

    test rax, rax
    jz .not_found

    mov rdi, [rax+16]
    call print_string
    call print_newline
    jmp .exit

    .not_found:
        mov rdi, 2
        mov rsi, err_msg
        mov rdx, err_len
        mov rax, 1
        syscall
    
    .exit:
        mov rdi, 0
        call exit

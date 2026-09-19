section .text
global find_word
extern string_equals

find_word:
    push rbx
    push r12

    mov rbx, rdi
    mov r12, rsi

    .loop:
        test r12, r12
        jz .not_found

        mov rsi, [r12+8]
        mov rdi, rbx

        call string_equals
        test rax, rax
        jz .next_loop
        mov rax, r12
        jmp .end
        .next_loop:
            mov r12, [r12]
            jmp .loop
    .not_found:
        xor rax, rax
    .end:
        pop r12
        pop rbx
        ret


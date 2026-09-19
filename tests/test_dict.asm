section .data
    %include "inc/colon.inc"
    %include "inc/words.inc"
    
    test_key1: db "third word", 0
    test_key2: db "second word", 0
    test_key3: db "first word", 0
    test_key4: db "nonexistent", 0
    test_key5: db "", 0
    
    pass_msg: db "PASS", 10
    pass_len: equ $ - pass_msg
    fail_msg: db "FAIL", 10
    fail_len: equ $ - fail_msg
    
    msg1: db "Test 1: third word", 10
    len1: equ $ - msg1
    msg2: db "Test 2: second word", 10
    len2: equ $ - msg2
    msg3: db "Test 3: first word", 10
    len3: equ $ - msg3
    msg4: db "Test 4: nonexistent", 10
    len4: equ $ - msg4
    msg5: db "Test 5: empty string", 10
    len5: equ $ - msg5
    msg6: db "Test 6: list structure", 10
    len6: equ $ - msg6

%macro print_str 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

section .text
    extern find_word
    extern string_equals
    extern exit
    global _start

_start:
    print_str msg1, len1
    mov rdi, test_key1
    mov rsi, dict_head
    mov rsi, [rsi]
    call find_word
    test rax, rax
    jz .t1_fail
    mov rdi, [rax+8]
    mov rsi, test_key1
    call string_equals
    test rax, rax
    jz .t1_fail
    print_str pass_msg, pass_len
    jmp .t2
.t1_fail:
    print_str fail_msg, fail_len

.t2:
    print_str msg2, len2
    mov rdi, test_key2
    mov rsi, dict_head
    mov rsi, [rsi]
    call find_word
    test rax, rax
    jz .t2_fail
    mov rdi, [rax+8]
    mov rsi, test_key2
    call string_equals
    test rax, rax
    jz .t2_fail
    print_str pass_msg, pass_len
    jmp .t3
.t2_fail:
    print_str fail_msg, fail_len

.t3:
    print_str msg3, len3
    mov rdi, test_key3
    mov rsi, dict_head
    mov rsi, [rsi]
    call find_word
    test rax, rax
    jz .t3_fail
    mov rdi, [rax+8]
    mov rsi, test_key3
    call string_equals
    test rax, rax
    jz .t3_fail
    print_str pass_msg, pass_len
    jmp .t4
.t3_fail:
    print_str fail_msg, fail_len

.t4:
    print_str msg4, len4
    mov rdi, test_key4
    mov rsi, dict_head
    mov rsi, [rsi]
    call find_word
    test rax, rax
    jnz .t4_fail
    print_str pass_msg, pass_len
    jmp .t5
.t4_fail:
    print_str fail_msg, fail_len

.t5:
    print_str msg5, len5
    mov rdi, test_key5
    mov rsi, dict_head
    mov rsi, [rsi]
    call find_word
    test rax, rax
    jnz .t5_fail
    print_str pass_msg, pass_len
    jmp .t6
.t5_fail:
    print_str fail_msg, fail_len

.t6:
    print_str msg6, len6
    mov rax, dict_head
    mov rax, [rax]
    test rax, rax
    jz .t6_fail
    mov rbx, rax
    mov rax, [rbx]
    test rax, rax
    jz .t6_pass
    mov rbx, rax
    mov rax, [rbx+8]
    test rax, rax
    jz .t6_fail
.t6_pass:
    print_str pass_msg, pass_len
    jmp .exit
.t6_fail:
    print_str fail_msg, fail_len

.exit:
    mov rdi, 0
    call exit
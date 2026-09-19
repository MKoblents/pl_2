section .data
    %include "inc/colon.inc"
    %include "inc/words.inc"
    
    ; Тестовые строки
    test_key1: db "third word", 0
    test_key2: db "second word", 0
    test_key3: db "first word", 0
    test_key4: db "nonexistent", 0
    test_key5: db "", 0
    
    ; Сообщения
    pass_msg: db "PASS", 10
    pass_len: equ $ - pass_msg
    fail_msg: db "FAIL", 10
    fail_len: equ $ - fail_msg
    test1_msg: db "Test 1: Find 'third word'", 10
    test1_len: equ $ - test1_msg
    test2_msg: db "Test 2: Find 'second word'", 10
    test2_len: equ $ - test2_msg
    test3_msg: db "Test 3: Find 'first word'", 10
    test3_len: equ $ - test3_msg
    test4_msg: db "Test 4: Find nonexistent word", 10
    test4_len: equ $ - test4_msg
    test5_msg: db "Test 5: Find empty string", 10
    test5_len: equ $ - test5_msg
    test6_msg: db "Test 6: Verify linked list structure", 10
    test6_len: equ $ - test6_msg

section .text
    extern find_word
    extern string_equals
    extern exit
    global _start

_start:
    ; Тест 1: Поиск "third word"
    mov rdi, test1_msg
    mov rax, 1
    mov rsi, test1_msg
    mov rdx, test1_len
    syscall
    
    mov rdi, test_key1
    mov rsi, dict_head
    mov rsi, [rsi]
    call find_word
    
    test rax, rax
    jz .test1_fail
    
    ; Проверяем, что нашли правильный узел
    mov rdi, [rax + 8]      ; ключ узла
    mov rsi, test_key1
    call string_equals
    test rax, rax
    jz .test1_fail
    
    mov rdi, pass_msg
    mov rax, 1
    mov rsi, pass_msg
    mov rdx, pass_len
    syscall
    jmp .test2
    
.test1_fail:
    mov rdi, fail_msg
    mov rax, 1
    mov rsi, fail_msg
    mov rdx, fail_len
    syscall

.test2:
    ; Тест 2: Поиск "second word"
    mov rdi, test2_msg
    mov rax, 1
    mov rsi, test2_msg
    mov rdx, test2_len
    syscall
    
    mov rdi, test_key2
    mov rsi, dict_head
    mov rsi, [rsi]
    call find_word
    
    test rax, rax
    jz .test2_fail
    
    mov rdi, [rax + 8]
    mov rsi, test_key2
    call string_equals
    test rax, rax
    jz .test2_fail
    
    mov rdi, pass_msg
    mov rax, 1
    mov rsi, pass_msg
    mov rdx, pass_len
    syscall
    jmp .test3
    
.test2_fail:
    mov rdi, fail_msg
    mov rax, 1
    mov rsi, fail_msg
    mov rdx, fail_len
    syscall

.test3:
    ; Тест 3: Поиск "first word"
    mov rdi, test3_msg
    mov rax, 1
    mov rsi, test3_msg
    mov rdx, test3_len
    syscall
    
    mov rdi, test_key3
    mov rsi, dict_head
    mov rsi, [rsi]
    call find_word
    
    test rax, rax
    jz .test3_fail
    
    mov rdi, [rax + 8]
    mov rsi, test_key3
    call string_equals
    test rax, rax
    jz .test3_fail
    
    mov rdi, pass_msg
    mov rax, 1
    mov rsi, pass_msg
    mov rdx, pass_len
    syscall
    jmp .test4
    
.test3_fail:
    mov rdi, fail_msg
    mov rax, 1
    mov rsi, fail_msg
    mov rdx, fail_len
    syscall

.test4:
    ; Тест 4: Поиск несуществующего слова
    mov rdi, test4_msg
    mov rax, 1
    mov rsi, test4_msg
    mov rdx, test4_len
    syscall
    
    mov rdi, test_key4
    mov rsi, dict_head
    mov rsi, [rsi]
    call find_word
    
    test rax, rax
    jnz .test4_fail
    
    mov rdi, pass_msg
    mov rax, 1
    mov rsi, pass_msg
    mov rdx, pass_len
    syscall
    jmp .test5
    
.test4_fail:
    mov rdi, fail_msg
    mov rax, 1
    mov rsi, fail_msg
    mov rdx, fail_len
    syscall

.test5:
    ; Тест 5: Поиск пустой строки
    mov rdi, test5_msg
    mov rax, 1
    mov rsi, test5_msg
    mov rdx, test5_len
    syscall
    
    mov rdi, test_key5
    mov rsi, dict_head
    mov rsi, [rsi]
    call find_word
    
    test rax, rax
    jnz .test5_fail
    
    mov rdi, pass_msg
    mov rax, 1
    mov rsi, pass_msg
    mov rdx, pass_len
    syscall
    jmp .test6
    
.test5_fail:
    mov rdi, fail_msg
    mov rax, 1
    mov rsi, fail_msg
    mov rdx, fail_len
    syscall

.test6:
    ; Тест 6: Проверка структуры связного списка
    mov rdi, test6_msg
    mov rax, 1
    mov rsi, test6_msg
    mov rdx, test6_len
    syscall
    
    ; Проверяем, что head не равен 0
    mov rax, dict_head
    mov rax, [rax]
    test rax, rax
    jz .test6_fail
    
    ; Проверяем, что первый узел указывает на второй (или 0 если только один узел)
    mov rbx, rax
    mov rax, [rbx]        ; next первого узла
    test rax, rax
    jz .test6_pass        ; если 0, значит только один узел - это ок
    
    ; Проверяем, что второй узел существует
    mov rbx, rax
    mov rax, [rbx + 8]    ; key второго узла
    test rax, rax
    jz .test6_fail
    
.test6_pass:
    mov rdi, pass_msg
    mov rax, 1
    mov rsi, pass_msg
    mov rdx, pass_len
    syscall
    jmp .exit
    
.test6_fail:
    mov rdi, fail_msg
    mov rax, 1
    mov rsi, fail_msg
    mov rdx, fail_len
    syscall

.exit:
    mov rdi, 0
    call exit
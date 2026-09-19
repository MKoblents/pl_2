section .data
%include "colon.inc"
%include "words.inc"

search_key: db "second word", 0

section .text
extern find_word
extern exit
extern dict_head
global _start

_start:
    mov rdi, search_key
    mov rsi, dict_head
    mov rsi, [rsi]
    call find_word
    
    mov rdi, 0
    call exit
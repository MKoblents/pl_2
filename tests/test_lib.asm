; test_lib.asm
section .text
%include "lib.inc"

global _start
_start:
    mov rdi, 0
    call exit
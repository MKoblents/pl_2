colon "third word", third_word
db "third word explanation", 0

colon "second word", second_word
db "second word explanation", 0

colon "first word", first_word
db "first word explanation", 0


global dict_head
section .data
dict_head: dq dict_node_%+NODE_COUNTER
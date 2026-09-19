%assign NODE_COUNTER 0
%assign PREV_NODE 0
dict_node_0 equ 0

%macro colon 2
    %assign NODE_COUNTER NODE_COUNTER + 1

dict_node_%+NODE_COUNTER:
        dq dict_node_%+PREV_NODE
        dq dict_key_%+NODE_COUNTER
        dq %2

dict_key_%+NODE_COUNTER: db %1, 0
    %2 equ $
    %assign PREV_NODE NODE_COUNTER
%endmacro

global dict_head
section .data
dict_head: dq dict_node_%+NODE_COUNTER
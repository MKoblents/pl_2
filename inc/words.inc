colon "welcome", entry_0
db "friendly greeting message", 0

colon "good morning", entry_1
db "daily salutation", 0

colon "won't", entry_2
db "will not contraction", 0

colon "re-enter", entry_3
db "hyphenated verb", 0

colon "f=ma", entry_4
db "newton second law", 0

colon "a&b", entry_5
db "ampersand test", 0

colon "Python", entry_6
db "uppercase programming language", 0

colon "python", entry_7
db "lowercase programming language", 0

colon "repeat", entry_8
db "first occurrence", 0

colon "repeat", entry_9
db "second occurrence overrides", 0

colon "m", entry_10
db "single letter m", 0

colon "n", entry_11
db "single letter n", 0

colon "999", entry_12
db "three nines", 0

colon "7", entry_13
db "lucky number", 0

colon "my_var", entry_14
db "underscore identifier", 0

colon "", entry_15
db "blank string accepted", 0

colon " start", entry_16
db "whitespace at beginning", 0

colon "end ", entry_17
db "whitespace at end", 0

colon "col1	col2", entry_18
db "tab separated values", 0

colon 'he said "hi"', entry_19
db "nested quotes test", 0

colon "they're", entry_20
db "plural contraction", 0

colon "qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq", entry_21
db "two hundred fifty four chars", 0

colon "ppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp", entry_22
db "two hundred fifty five chars", 0

colon "testword", entry_23
db "generic test case", 0

colon "dog", entry_24
db "domestic animal", 0

colon "catalog", entry_25
db "list of items", 0

colon "42", entry_26
db "answer to everything", 0

global dict_head
section .data
dict_head: dq dict_node_%+NODE_COUNTER

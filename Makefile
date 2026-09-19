NASM = nasm
LD = ld
NASMFLAGS = -f elf64

all:main

main: main.o dict.o lib.o
	$(LD) main.o dict.o lib.o -o main

main.o: main.asm colon.inc words.inc
	$(NASM) $(NASMFLAGS) main.asm -o main.o

dict.o: dict.asm dict.inc colon.inc
	$(NASM) $(NASMFLAGS) dict.asm -o dict.o

lib.o: lib/lib.asm lib.inc
	$(NASM) $(NASMFLAGS) lib/lib.asm -o lib.o

test: main
	@echo "Тест 1: Поиск существующего слова"
	@echo "second word" | ./main
	@echo ""
	@echo "Тест 2: Поиск несуществующего слова"
	@echo "unknown" | ./main
	@echo ""

clean:
	rm -f *.o main

.PHONY: all test clean
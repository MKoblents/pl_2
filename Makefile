SRC_DIR = src
INC_DIR = inc
BUILD_DIR = build

NASM = nasm
LD = ld
NASMFLAGS = -f elf64 -I $(INC_DIR)/

MAIN = $(BUILD_DIR)/main
MAIN_O = $(BUILD_DIR)/main.o
DICT_O = $(BUILD_DIR)/dict.o
LIB_O = $(BUILD_DIR)/lib.o

all: $(MAIN)

$(MAIN): $(MAIN_O) $(DICT_O) $(LIB_O)
	$(LD) $^ -o $@

$(MAIN_O): $(SRC_DIR)/main.asm $(INC_DIR)/colon.inc $(INC_DIR)/words.inc
	@mkdir -p $(BUILD_DIR)
	$(NASM) $(NASMFLAGS) $< -o $@

$(DICT_O): $(SRC_DIR)/dict.asm $(INC_DIR)/dict.inc $(INC_DIR)/colon.inc
	@mkdir -p $(BUILD_DIR)
	$(NASM) $(NASMFLAGS) $< -o $@

$(LIB_O): lib/lib.asm
	@mkdir -p $(BUILD_DIR)
	$(NASM) $(NASMFLAGS) $< -o $@


test: $(MAIN)
	@echo "Running Python tests..."
	@python3 tests/test_app.py

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all test clean
#!/bin/bash

set -e

echo "========================================="
echo "Running Dictionary Tests"
echo "========================================="
echo ""

# Компиляция тестов
echo "Compiling tests..."
nasm -f elf64 tests/test_dict.asm -o build/test_dict.o
nasm -f elf64 src/dict.asm -o build/dict.o
nasm -f elf64 lib/lib.asm -o build/lib.o
ld build/test_dict.o build/dict.o build/lib.o -o build/test_dict

echo ""
echo "Running unit tests..."
echo "-----------------------------------------"
./build/test_dict
echo "-----------------------------------------"
echo ""

# Интеграционные тесты
echo "Running integration tests..."
echo "-----------------------------------------"

echo "Test: Search for existing word 'third word'"
echo "third word" | ./build/main
echo ""

echo "Test: Search for existing word 'second word'"
echo "second word" | ./build/main
echo ""

echo "Test: Search for existing word 'first word'"
echo "first word" | ./build/main
echo ""

echo "Test: Search for nonexistent word"
echo "nonexistent" | ./build/main || true
echo ""

echo "Test: Empty input"
echo "" | ./build/main || true
echo ""

echo "-----------------------------------------"
echo ""
echo "All tests completed!"
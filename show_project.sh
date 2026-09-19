#!/bin/bash

echo "========================================="
echo "PROJECT FILES FOR REVIEW"
echo "========================================="
echo ""

# Функция для вывода файла с заголовком
print_file() {
    echo "========================================="
    echo "FILE: $1"
    echo "========================================="
    if [ -f "$1" ]; then
        cat "$1"
    else
        echo "FILE NOT FOUND: $1"
    fi
    echo ""
    echo ""
}

# Конфигурационные файлы
print_file ".gitignore"
print_file ".gitlab-ci.yml"
print_file ".gitmodules"
print_file "Makefile"
print_file "README.md"

# Исходники
print_file "src/main.asm"
print_file "src/dict.asm"

# Заголовочные файлы
print_file "inc/colon.inc"
print_file "inc/dict.inc"
print_file "inc/lib.inc"
print_file "inc/words.inc"

# Тесты
print_file "tests/test_dict.asm"
print_file "tests/run_tests.sh"

# Библиотека из субмодуля
print_file "lib/lib.asm"

echo "========================================="
echo "END OF PROJECT FILES"
echo "========================================="

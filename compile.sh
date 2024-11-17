echo "Compiler tool started for Temperate"

echo "Compiling assembly files..."
nasm -f elf64 -o main.o main.asm
nasm -f elf64 -o console.o scripts/console.asm
nasm -f elf64 -o converters.o scripts/converters.asm

echo "Compiling C files..."
gcc -c scripts/functions.c -o functions.o

echo "Linking files..."
gcc main.o console.o functions.o converters.o -o temperate

echo "Compiler tool finished. Run ./temperate to run."
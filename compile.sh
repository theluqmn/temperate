echo "Compiler tool started for Temperate"

nasm -f elf64 -o main.o main.asm
nasm -f elf64 -o console.o scripts/console.asm
nasm -f elf64 -o converters.o scripts/converters.asm
ld -o temperate main.o console.o converters.o

echo "Compiler tool finished. Run ./temperate to run."
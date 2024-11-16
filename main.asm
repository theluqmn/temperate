section .data
    greet: db "Temperate - temperature converter", 0
    enter_unit: db "Enter unit (c/f): ", 0
    enter_temp: db "Enter temperature: ", 0

    symbol_celcius: db "c", 0
    symbol_fahrenheit: db "f", 0

    text_celcius: db "Celsius: ", 0
    text_fahrenheit: db "Fahrenheit: ", 0
    text_error: db "Error: invalid unit", 0

section .bss
    unit: resb 1
    temp: resb 1

section .text
    global _start

    extern _console_out
    extern _console_space
    extern _console_get
    extern _exit

    _start:
        mov rax, greet
        call _console_out
        call _console_space

        ; input unit and temperature
        mov rax, enter_unit
        call _console_out
        call _console_space
        call _console_get
        mov [unit], rbx

        mov rax, enter_temp
        call _console_out
        call _console_space
        call _console_get
        mov [temp], rbx

        ; convert to fahrenheit
        mov rax, [unit]
        cmp rax, [symbol_celcius]
        jmp _fahrenheit

        ; convert to celcius
        cmp rax, [symbol_fahrenheit]

        ; invalid unit
        mov rax, text_error
        call _console_out
        call _console_space
        call _exit

    _fahrenheit: ; converting to fahrenheit
        mov rax, [temp]
        mov rbx, 18

        mul rbx
        mov rbx, 10
        div rbx

        add rax, 32
        push rax

        mov rax, text_fahrenheit
        call _console_out

        pop rax
        call _console_out
        call _console_space

        call _exit
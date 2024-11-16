section .data
    greet: db "Temperate - temperature converter", 0
    enter_unit: db "Enter current unit (c/f): ", 0
    enter_temp: db "Enter current temperature: ", 0

    symbol_celcius: db "c", 0
    symbol_fahrenheit: db "f", 0

    text_celcius: db "Celsius: ", 0
    text_fahrenheit: db "Fahrenheit: ", 0
    text_error: db "Error: invalid unit", 0
    text_degrees: db " degrees", 0

section .bss
    unit: resb 8
    temperature: resb 8

section .text
    global _start

    extern _console_out
    extern _console_space
    extern _console_get
    extern _exit

    extern num_to_string

    _start:
        mov rax, greet
        call _console_out
        call _console_space

        ; input unit and temperature
        mov rax, enter_unit
        call _console_out
        call _console_get
        mov [unit], rbx

        mov rax, enter_temp
        call _console_out
        call _console_get
        mov [temperature], rbx
        
        mov al, [unit]

        ; convert to fahrenheit
        cmp al, 'c'
        je fahrenheit

        ; convert to celcius
        cmp al, 'f'
        je celcius

        ; invalid unit
        mov rax, text_error
        call _console_out
        call _console_space

        call _exit

        fahrenheit: ; converting to fahrenheit
            ; calculation
            mov rax, [temperature]
            imul rax, 9
            xor rdx, rdx
            mov rbx, 5
            div rbx
            add rax, 32

            push rax

            ; output
            mov rax, text_fahrenheit
            call _console_out

            pop rax
            call num_to_string

            mov rax, rbx
            call _console_out
            mov rax, text_degrees
            call _console_out
            call _console_space

            call _exit
        
        celcius:
            ; calculation
            mov rax, [temperature]
            mov rbx, 9
            imul rax, rbx
            xor rdx, rdx
            mov rbx, 5
            div rbx
            add rax, 32
            push rax

            ; output
            mov rax, text_celcius
            call _console_out

            pop rax
            call num_to_string

            mov rax, rbx
            call _console_out
            mov rax, text_degrees
            call _console_out
            call _console_space

            call _exit
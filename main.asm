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
    text_pass: db "pass", 0

section .bss
    unit: resb 8
    temperature: resb 8

section .text
    global main

    extern _console_out
    extern _console_space
    extern _console_get
    extern _exit

    extern num_to_string
    extern string_to_num

    extern celcius_to_fahrenheit
    extern fahrenheit_to_celcius

    main:
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

        fahrenheit:
            mov rax, temperature
            call string_to_num

            mov rdi, rbx
            call celcius_to_fahrenheit
            
            call _exit

        celcius:
            mov rax, temperature
            call string_to_num
            
            mov rdi, rbx
            call fahrenheit_to_celcius

            call _exit
        
    _pass:
        mov rax, text_pass
        call _console_out
        call _console_space
        ret
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
    extern string_to_num

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

        ; Debug print
        mov rax, rbx
        call string_to_num
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
            ; Get temperature value (already in rbx from string_to_num)
            push rbx            ; save original temperature
            mov rax, rbx        ; copy temperature to rax
            mov rbx, 9         
            mul rbx             ; temp * 9
            mov rbx, 5
            push rdx            ; save high bits
            xor rdx, rdx        ; clear rdx
            div rbx             ; (temp * 9) / 5
            add rax, 32         ; add 32

            push rax            ; save result

            mov rax, text_fahrenheit
            call _console_out

            pop rax
            mov rsi, rax
            call num_to_string
            
            mov rax, rbx
            call _console_out
            mov rax, text_degrees
            call _console_out
            call _console_space

            call _exit
        
        celcius:
            ; calculation (F - 32) * 5/9
            mov rax, [temperature]
            sub rax, 32        ; subtract 32 first
            mov rbx, 5
            mul rbx            ; multiply by 5
            xor rdx, rdx
            mov rbx, 9
            div rbx            ; divide by 9

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
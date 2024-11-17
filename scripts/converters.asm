section .data
    len db 0                ; Length of the resulting string

section .bss
    buffer resb 20          ; Reserve space for the string (20 bytes)

section .text
    global num_to_string    ; Make the subroutine globally accessible
    global string_to_num    ; Make the subroutine globally accessible

; Subroutine: num_to_string
; Converts the number in RAX to a string and stores it in 'buffer'
num_to_string:
    mov rbx, buffer + 19    ; Point RBX to the end of the buffer
    mov byte [rbx], 0       ; Null-terminate the string
    mov rcx, 10             ; Divisor for decimal conversion

    num_to_string_loop:
        xor rdx, rdx            ; Clear RDX (remainder)
        test rax, rax           ; Check if RAX is zero
        jz num_to_string_done                 ; If RAX is zero, we're done

        div rcx                  ; Divide RAX by 10
        add dl, '0'              ; Convert remainder to ASCII
        dec rbx                  ; Move back in the buffer
        mov [rbx], dl           ; Store ASCII character in buffer
        inc byte [len]          ; Increment length of the string
        jmp num_to_string_loop              ; Repeat for next digit

    num_to_string_done:
        ret                      ; Return from subroutine

string_to_num:
    mov rsi, rax            ; source string pointer
    xor rax, rax            ; zero out our accumulator
    xor rbx, rbx            ; zero out our result register

    string_to_num_loop:
        movzx rdx, byte [rsi]   ; load next character
        test rdx, rdx           ; check for string end
        jz string_to_num_done
        
        sub rdx, '0'            ; convert ASCII to number
        lea rax, [rax*5]        ; multiply by 5
        lea rax, [rax*2]        ; multiply by 2 (total *10)
        add rax, rdx            ; add new digit
        
        inc rsi                 ; move to next character
        jmp string_to_num_loop

    string_to_num_done:
        mov rbx, rax            ; store final result
        ret

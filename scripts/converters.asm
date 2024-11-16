section .data
    len db 0                ; Length of the resulting string

section .bss
    buffer resb 20          ; Reserve space for the string (20 bytes)

section .text
    global num_to_string    ; Make the subroutine globally accessible

; Subroutine: num_to_string
; Converts the number in RAX to a string and stores it in 'buffer'
num_to_string:
    mov rbx, buffer + 19    ; Point RBX to the end of the buffer
    mov byte [rbx], 0       ; Null-terminate the string
    mov rcx, 10             ; Divisor for decimal conversion

convert:
    xor rdx, rdx            ; Clear RDX (remainder)
    test rax, rax           ; Check if RAX is zero
    jz done                 ; If RAX is zero, we're done

    div rcx                  ; Divide RAX by 10
    add dl, '0'              ; Convert remainder to ASCII
    dec rbx                  ; Move back in the buffer
    mov [rbx], dl           ; Store ASCII character in buffer
    inc byte [len]          ; Increment length of the string
    jmp convert              ; Repeat for next digit

done:
    ret                      ; Return from subroutine    ret                      ; Return from subroutine
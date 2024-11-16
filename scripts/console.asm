section .data
    newline: db 10

section .bss
    input: resb 32

section .text
    global _console_out
    global _console_space
    global _console_get
    global _exit

_console_out:
    ; subroutine to print out the message stored in rax
    push rax
    mov rbx, 0
    message_len_loop:
        ; increase pointer for the message and count
        inc rax
        inc rbx
        mov cl, [rax] ; load byte to memory address
        cmp cl, 0 ; check for null terminator
    jne message_len_loop
 
    ; print out message
    mov rax, 1
    mov rdi, 1
    pop rsi ; retrive original memory address from stack into rsi
    mov rdx, rbx ; length of message to print
    syscall
    ret ; return to code/end of subroutine

_console_space:
    ; subroutine to print out new line
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    ret ; end of subroutine

_console_get:
    mov rax, 0
    mov [input], rax
    ; subroutine that fetches input
    mov rax, 0
    mov rdi, 0
    mov rsi, input ; rbx is where the input will be stored
    mov rdx, 256 ; 256 bytes allocation
    syscall
    mov rbx, [input] ; move input to rbx
    ret ; end of subroutine

_exit:
    ; subroutine to quit code. required, otherwise segmentation fault.
    mov rax, 60
    mov rdi, 0
    syscall
    ret ; end of subroutine
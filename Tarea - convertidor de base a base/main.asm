section .data
    ; Constantes de formato
    fmt_input db "Ingresa un número en base %d: ", 0
    fmt_output db "El número en base %d es: %s", 10, 0
    fmt_error db "Error: el número ingresado no es válido", 10, 0

    ; Bases
    base_in dw 0 ; Base de entrada
    base_out dw 0 ; Base de salida

    ; Números
    num_in db 256 ; Número en base de entrada
    num_out db 256 ; Número en base de salida

    ; Tabla de caracteres para conversiones a bases mayores a 10
    digits db "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"

section .text
global _start

extern printf, scanf

_start:
    ; Pedimos al usuario que ingrese la base de entrada
    mov esi, fmt_input
    xor eax, eax
    mov ebx, 10
    call printf
    mov esi, num_in
    mov edi, base_in
    mov edx, 2
    call scanf

    ; Pedimos al usuario que ingrese el número en base de entrada
    mov esi, fmt_input
    mov eax, [base_in]
    call printf
    mov esi, num_in
    mov edi, num_in
    mov edx, 256
    call scanf

    ; Convertimos el número a decimal
    mov eax, 0
    mov ecx, 0
    mov ebx, [base_in]
    mov edi, num_in
    mov esi, digits
convert_loop:
    movzx edx, byte [edi + ecx]
    cmp edx, 0
    je convert_done
    imul eax, ebx
    movzx edx, byte [esi + edx]
    add eax, edx
    inc ecx
    jmp convert_loop
convert_done:

    ; Convertimos el número a la base de salida
    mov ebx, [base_out]
    mov ecx, 0
convert_loop2:
    mov edx, 0
    div ebx
    movzx ecx, al
    movzx edx, dl
    mov byte [num_out + ecx], byte [digits + edx]
    inc cl
    test eax, eax
    jnz convert_loop2

    ; Imprimimos el resultado
    mov esi, fmt_output
    mov eax, [base_out]
    call printf
    mov esi, num_out
    call printf

    ; Salimos del programa
    mov eax, 0
    mov ebx, 0
    ret

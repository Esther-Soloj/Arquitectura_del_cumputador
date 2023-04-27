section .data
    num dw 1234 ; Número entero a convertir
    str db 16 ; Espacio para almacenar la cadena
    fmt db "%d", 0 ; Formato de salida

section .text
global _start

extern sprintf, printf

_start:
    ; Convertimos el número entero a una cadena
    mov esi, fmt
    mov edi, str
    mov eax, dword [num]
    push eax
    call sprintf
    add esp, 4 ; Liberamos el espacio de la pila

    ; Imprimimos la cadena resultante
    mov esi, str
    mov eax, 0
    call printf

    ; Salimos del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

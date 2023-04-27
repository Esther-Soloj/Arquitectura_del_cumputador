section .data
    ; Cadena de ejemplo en minúsculas
    str db "hola mundo", 0
    ; Longitud de la cadena
    len equ $-str

section .text
global _start

_start:
    ; Imprimimos la cadena original
    mov eax, 4
    mov ebx, 1
    mov ecx, str
    mov edx, len
    int 0x80

    ; Convertimos la cadena a mayúsculas
    mov esi, str
    mov edi, str
loop1:
    mov al, byte [esi]
    cmp al, 0
    je done1
    cmp al, 'a'
    jb skip1
    cmp al, 'z'
    ja skip1
    sub al, 32
skip1:
    mov byte [edi], al
    inc esi
    inc edi
    jmp loop1
done1:

    ; Imprimimos la cadena convertida a mayúsculas
    mov eax, 4
    mov ebx, 1
    mov ecx, str
    mov edx, len
    int 0x80

    ; Salimos del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
